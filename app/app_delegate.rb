class AppDelegate

  include BW::KVO

  attr_accessor :user

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    @window.makeKeyAndVisible

    @name_label = UILabel.alloc.initWithFrame([[0, 0], [100, 30]])
    @window.addSubview(@name_label)

    @email_label = UILabel.alloc.initWithFrame(
      [[0, @name_label.frame.size.height + 10], @name_label.frame.size]
    )
    @window.addSubview(@email_label)

    @id_label = UILabel.alloc.initWithFrame(
      [[0, @email_label.frame.origin.y + @email_label.frame.size.height + 10],
        @name_label.frame.size
      ]
    )
    @window.addSubview(@id_label)

    self.user = User.new

    %w(name id email).each do |prop|
      observe(self.user, prop) do |old_value, new_value|
        instance_variable_get("@#{prop}_label").text = new_value
      end
    end

    true
  end

  def animate_to_next_point
    @current_index += 1
    @current_index = @current_index % @points.count

    UIView.animateWithDuration(
      2,
      delay: 1,
      options: UIViewAnimationOptionCurveLinear,
      animations: lambda {
        @view.frame = [@points[@current_index], [100, 100]]
      },
      completion: lambda {|finished|
        self.animate_to_next_point
      }
    )
  end
end
