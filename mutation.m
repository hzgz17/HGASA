% mutation operator
function pop=mutation(pop_muta,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points)
Pm=0.2;
for i=1:size(pop_muta,1)
    if rand<Pm
        chromosome=pop_muta(i,:);
        if randi(6)<=6   %0-1 relocation
            pop(i,:)=relocate(chromosome,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points);
        elseif randi(6)>2&&randi(6)<=4  %1-1 exchange
            pop(i,:)=exchange(chromosome,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points);
        else    %2-opt
            pop(i,:)=opt(chromosome,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points);
        end
    else
        pop(i,:)=pop_muta(i,:);  
    end
end
end
