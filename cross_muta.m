% crossover+mutation+simulated annealing
function pop_cross=cross_muta(pop_sel,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points,T)
Pc=0.98;
for i=1:size(pop_sel,1)
    if rand<Pc
        nnper1=randperm(size(pop_sel,1),2);
        value1=object_ls(pop_sel(nnper1(1),:),distance,depart,lunch_points);
        value2=object_ls(pop_sel(nnper1(2),:),distance,depart,lunch_points);
        if value1<=value2
            parentA=pop_sel(nnper1(1),:);
        else
            parentA=pop_sel(nnper1(2),:);
        end
        nnper2=randperm(size(pop_sel,1),2);
        value3=object_ls(pop_sel(nnper2(1),:),distance,depart,lunch_points);
        value4=object_ls(pop_sel(nnper2(2),:),distance,depart,lunch_points);
        if value3<=value4
            parentB=pop_sel(nnper2(1),:);
        else
            parentB=pop_sel(nnper2(2),:);
        end
        offspring1=OX2(parentA,parentB,lunch_points);
        cross_synch=potential_feasible(offspring1,distance,timewindow,servicetime,quality,depart,worktime,syn_points,num_caregiver,num_patient,num_syn,lunch_points);
        if cross_synch==1
            [feasible,~,~]=judgeroute(offspring1,distance,timewindow,servicetime,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points);
            if feasible==1
                offspringB=offspring1;
            else
                offspringB=localmove(parentB,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points);
            end
        else
            offspringB=localmove(parentB,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points);
        end
        pop_muta=mutation(offspringB,distance,timewindow,servicetime,quality,depart,syn_points,worktime,num_caregiver,num_patient,num_syn,lunch_points);
        cost1=min(value3,value4);
        cost2=object(pop_muta,distance,depart,lunch_points);
        delta=cost2-cost1;
        if cost2<cost1
            pop_cross(i,:)=pop_muta;
        else
            p=exp(-delta/T);
            if rand<p
                pop_cross(i,:)=pop_muta;
            else
                pop_cross(i,:)=parentB;
            end
        end
    else
         pop_cross(i,:)=pop_sel(i,:);
    end
end
end