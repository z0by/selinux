require 'mixlib/shellout'

action :enforcing do
  template '/etc/selinux/config' do
    source 'config.erb'
    variables(
      :selinux_mode => 'enforcing'
    )

  end
  if not @current_resource.status == 'enforcing'
     command = Mixlib::ShellOut.new("setenforce Enforcing")
     command.run_command
  end
end

action :permissive do
  template '/etc/selinux/config' do
    source 'config.erb'
    variables(
      :selinux_mode => 'permissive'
    )
  end
  if not @current_resource.status == 'enforcing'
    command = Mixlib::ShellOut.new("setenforce Enforcing")
    command.run_command
  end
end


action :disable do
  template '/etc/selinux/config' do
    source 'config.erb'
    variables(
      :selinux_mode => 'disabled'
    )
  end
end

def load_current_resource
  @current_resource = Chef::Resource::SelinuxStatus.new(new_resource.name)
  getenforce = Mixlib::ShellOut.new("getenforce")
  getenforce.run_command 
  @current_resource.status(getenforce.stdout.chomp.downcase)
  @current_resource
end
          

  

