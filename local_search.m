% local search procedure
function [pop,value]=local_search(pop_muta,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points)
for i=1:size(pop_muta,1)
    bestvalue=object_ls(pop_muta(i,:),distance,depart,lunch_points);
    outputs=bestvalue;
    value(i)=bestvalue;
    pop(i,:)=pop_muta(i,:);
    chromosome=pop_muta(i,:);
    m=1;
    while m<=60&&outputs>=bestvalue
        if randi(6)<=2   %0-1 relocation
            pop_search(i,:)=relocate(chromosome,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points);
        elseif randi(6)>2&&randi(6)<=4  %1-1 exchange
            pop_search(i,:)=exchange(chromosome,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points);
        else   %2-opt
            pop_search(i,:)=opt(chromosome,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points);    
        end
        outputs=object_ls(pop_search(i,:),distance,depart,lunch_points);
        m=m+1;
        if outputs<value(i)
            value(i)=outputs;
            pop(i,:)=pop_search(i,:);
        end
    end
end
end
