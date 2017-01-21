Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'
  config.vm.hostname = 'preseeder'
  config.vm.network "forwarded_port", guest: 80, host:8080
  config.vm.provider 'virtualbox' do |vb|
  config.vbguest.no_install = true
    vb.name = 'preseeder'
    vb.cpus = 1
    vb.memory = 256
  end
  config.vm.provision 'shell', path: './scripts/install_httpd.sh', privileged: true
  config.vm.provision 'file', source: './files/preseed.conf', destination: '/tmp/preseed.conf'

  config.vm.provision(
    'shell',
    path: './scripts/configure_httpd.sh',
    privileged: true
  )

  Dir['./files/preseeds/*.cfg'].each do |preseed_file|
    basepath = File.basename(preseed_file)
    config.vm.provision 'file', source: preseed_file, destination: "/tmp/#{basepath}"
    config.vm.provision(
      'shell',
      inline: "mv /tmp/#{basepath} /var/www/html/preseed/#{basepath}; chown root: /var/www/html/preseed/#{basepath}"
    )
  end

  config.vm.provision 'shell', inline: 'chcon -t httpd_sys_content_t /var/www/html/preseed/*', privileged: true
end
