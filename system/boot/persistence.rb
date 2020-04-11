Brainbase::Application.boot(:persistence) do |app|
  start do
    config = app['db.config']
    config.auto_registration(app.root + 'lib/brainbase')

    register('container', ROM.container(app['db.config'])).inspect
  end
end
