create_project project_1 ./project_1 -part xc7k70tfbv676-1
ipx::infer_core -vendor user.org -library user -taxonomy /UserIP ./Verilog/module
ipx::edit_ip_in_project -upgrade true -name edit_ip_project -directory ./project_1/project_1.tmp ./Verilog/module/component.xml
ipx::current_core ./Verilog/module/component.xml
update_compile_order -fileset sources_1
ipx::merge_project_changes files [ipx::current_core]
set_property core_revision 2 [ipx::current_core]
ipx::update_source_project_archive -component [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::check_integrity [ipx::current_core]
ipx::save_core [ipx::current_core]
ipx::move_temp_component_back -component [ipx::current_core]
close_project -delete
#set_property  ip_repo_paths  ./ip_repo [current_project]
update_ip_catalog
