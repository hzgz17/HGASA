% local move for generating the initial solution 
function chromosome=localmove(pop_muta,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points)
for i=1:size(pop_muta,1)
    chromosome=pop_muta(i,:);
    m=1;
    while m<=20
        nd=chromosome(ismember(chromosome,1)==0);
        no_depots=find(chromosome~=1);
        b=length(no_depots);
        point=randperm(b,2);
        cp(1)=find(chromosome==nd(point(1)));
        cp(2)=find(chromosome==nd(point(2)));
        cp=sort(cp);
        if randi(6)<=2   %0-1 relocation
            chromosome_delete=[chromosome(1:cp(1)-1) chromosome(cp(1)+1:end)];
            insert=randi(length(chromosome_delete)-1,1);
            offspring=[chromosome_delete(1:insert) chromosome(cp(1)) chromosome_delete(insert+1:end)];
            cross_synch=potential_feasible(offspring,distance,timewindow,servicetime,quality,depart,worktime,syn_points,num_caregiver,num_patient,num_syn,lunch_points);
            if cross_synch==1                
                chromosome=offspring;
            end
        elseif randi(6)>2&&randi(6)<=4  %1-1 exchange
            offspring=chromosome;
            temp=offspring(cp(1));
            offspring(cp(1))=offspring(cp(2));
            offspring(cp(2))=temp;
            cross_synch=potential_feasible(offspring,distance,timewindow,servicetime,quality,depart,worktime,syn_points,num_caregiver,num_patient,num_syn,lunch_points);
            if cross_synch==1
                chromosome=offspring;
            end
        else    %2-opt
            depots=find(chromosome==1);
            p=randperm(length(depots)-1,2);
            p=sort(p);
            part1=chromosome(depots(p(1))+1:depots(p(1)+1)-1);
            position1=randi(length(part1));
            part11=part1(1:position1);
            part12=part1(position1+1:end);
            part2=chromosome(depots(p(2))+1:depots(p(2)+1)-1);
            position2=randi(length(part2));
            part21=part2(1:position2);
            part22=part2(position2+1:end);
            offspring=[chromosome(1:depots(p(1))) part11 part22 chromosome(depots(p(1)+1):depots(p(2))) part21 part12 chromosome(depots(p(2)+1):end)];
            cross_synch=potential_feasible(offspring,distance,timewindow,servicetime,quality,depart,worktime,syn_points,num_caregiver,num_patient,num_syn,lunch_points);
            if cross_synch==1
                chromosome=offspring;
            end
        end
        m=m+1;
    end
end
end
