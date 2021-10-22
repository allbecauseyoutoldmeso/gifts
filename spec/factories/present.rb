# frozen_string_literal: true

FactoryBot.define do
  factory :present do
    toys = [
      'Chemistry set',
      'Etch A Sketch',
      'Kaleidoscope',
      'Magic 8-Ball',
      'Sea Monkeys',
      'Spinning top',
      'View-Master',
      'Wooly Willy',
      'Zoetrope',
      'Kazoo',
      'Moo box',
      'Pop Toob',
      'Whistle',
      'Whirly tube',
      'Beyblade',
      'Diabolo',
      'Frisbee',
      'Gyroscope',
      'Hula hoop',
      'Whee-Lo',
      'Pinwheel',
      'Top',
      'Yo-yo',
      'Fidget Spinner',
      'Robot dog',
      'Drinking bird',
      'Fidget Spinner',
      'Magic 8-Ball',
      'Pin Art',
      'Easy-Bake Oven',
      'Pez dispenser',
      'Snow cone machine',
      'Tea set',
      'Ant Farm',
      'Cleversticks',
      'Colorforms',
      'Crayola Crayons',
      'Creepy Crawlers',
      'Lego',
      'Lite-Brite',
      'Magna Doodle',
      'Magnetic Poetry',
      'Mr Potato Head',
      'Play-Doh',
      'Rainbow Loom',
      'Shrinky Dinks',
      'Silly Putty',
      'Spirograph'
    ]

    name { toys.sample }
    event factory: :event
  end
end
