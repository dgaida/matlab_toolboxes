function joinandsim()
%%
% This Function joins the files volumeflow_substrate_id_user files at the
% end of volumeflow_substrate_id_user_1 files. 

% since only the first value is applied to the plant, during the last
% iteration the input over control horizon is not applied. As a result the
% fitness expected by the optimization algorithm is not obtained. Therefore
% we copy the values(starting from second column-since first is already used)
% from volumeflow_substrate_id_user file to volumeflow_substrate_id_user_1 file. 

%%
% In order to do this first the volumeflow_substrate_id_user file is copied
% to a variable, and then that variable is copied to
% volumeflow_substrate_id_user_1 file.
%%
cur_fol=pwd;
nm=20;           % Number of files
plant_id='sunderhook';
N=30;
%%
for i=1:nm
    fol=[cur_fol, filesep, sprintf('Case%i',i)];
    cd(fol);
    [substrate]=load_biogas_mat_files(plant_id);
    n_substrate= substrate.getNumSubstratesD();  
    %%
    for isubstrate= 1:n_substrate
          substrate_id= char(substrate.getID(isubstrate));
          % Loading the volumeflow_substrate_id_user file
          vname1= sprintf('volumeflow_%s_user', substrate_id); 
          load(vname1);
          vdata1= eval(sprintf('volumeflow_%s_user', ...
                  substrate_id) );

          eval( sprintf('%s= %s;', vname1, 'vdata1') );

          len=eval(sprintf('size(volumeflow_%s_user,2)',substrate_id));
          %%
          % Copy the values from volumeflow_substrate_id_user file to an arbitrary variable         
          for j=1:len-1
          mat(:,j)=vdata1(:,j+1);
          end
          %%
          % Loading the volumeflow_substrate_id_user_1 file
          vname2= sprintf('volumeflow_%s_user_1', substrate_id); 
          load(vname2);
          vdata1= eval(sprintf('volumeflow_%s_user', ...
                  substrate_id) );

          eval( sprintf('%s= %s;', vname1, 'vdata1') );
          % Getting the required values
          len1=eval(sprintf('size(volumeflow_%s_user,2)',substrate_id));
          last_c_horizon= eval( sprintf('volumeflow_%s_user(1,end)', ...
                                substrate_id) );
          % Checking whether the changes have been made or not
          %%
          if last_c_horizon==N
            delta=vdata1(1,3)-vdata1(1,1);
            %%
            % Copying the values but the first in volumeflow_substrate_id_user_1 will 
            % appear to be continuous and will not contain the first row of 
            % volumeflow_substrate_id_user file
            
            for k=1:2:len-1
                  vdata1(1,len1+k)=k-1+last_c_horizon+(0.9*delta);
                vdata1(2,len1+k)=mat(2,k);
            end
            for k=2:2:len-1
                  vdata1(1,len1+k)=k-2+last_c_horizon+delta;
                vdata1(2,len1+k)=mat(2,k);
            end
            % Saving the variable          
            eval( sprintf('%s= %s;', vname1, 'vdata1') );
            save(sprintf('volumeflow_%s_user_1', substrate_id),sprintf('volumeflow_%s_user',substrate_id));
          else
            str1=sprintf('The Changes have already been made for case %d',nm);
            str2=sprintf('Therefore substrate_%s_user_1 is skipped',substrate_id);
            disp(str1);
            disp(str2);
          end
    end
end
cd(cur_fol);
simmodel(cur_fol,nm,plant_id);

