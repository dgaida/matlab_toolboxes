%% gui_plant_delete_fnc
% Deletes elements on fermenter and bhkw panel of <gui_plant.html |gui_plant|>
%
function handles= gui_plant_delete_fnc(handles)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%
%delete fields on the right side after changing file
if isfield (handles, 'ftext')
    
  if isfield(handles, 'frame1')
    delete(handles.frame1)
  end

%     if isfield(handles,'frame2')
%         delete(handles.frame2)
%     end

  f_vars=fieldnames(handles.ftext);
  f_vars_count=size(f_vars,1);

  for i=1:f_vars_count
    f_del=f_vars(i);
    f_del=char(f_del);
    delete(handles.ftext.(f_del));
  end

  handles= rmfield(handles, 'ftext');
  clear f_del
    
end

%%
%

if isfield (handles, 'f_edit')
    
  f_vars=fieldnames(handles.f_edit);
  f_vars_count=size(f_vars,1);

  for i=1:f_vars_count
    f_del=f_vars(i);
    f_del=char(f_del);
    delete(handles.f_edit.(f_del));
  end

  handles= rmfield(handles, 'f_edit');

end

%%
%

if isfield (handles, 'f_but')
    
  f_vars=fieldnames(handles.f_but);
  f_vars_count=size(f_vars,1);

  for i=1:f_vars_count
    f_del=f_vars(i);
    f_del=char(f_del);
    delete(handles.f_but.(f_del));
  end

  handles= rmfield(handles, 'f_but');
    
end

%%


