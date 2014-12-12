module MembersHelper

  def role user_tel
    case user_tel.role
    when 10 then "Guest"
    when 20 then "Write"
    when 30 then "Admin"
    else "UnKnown"
    end
  end

  def roles
    {
      Guest: 10,
      Write: 20,
      Admin: 30
    }
  end
end
