# 대학교 4개 리스팅
puts "Inserting university data.."
[
    ["서울대학교", "snu", true, "snu.ac.kr"],
    ["성균관대학교", "skku", false, ""],
    ["숭실대학교", "ss", false, ""],
    ["성신여자대학교", "sungshin", false, ""],
].each do |x|
  University.create(local_name: x[0], english_name: x[1], need_activation: x[2], email_domain: x[3])
end

#사용자
puts "Inserting user data.."
[
   [1, true, "이브이", "admin@snu.ac.kr", 1, 'password', 'password', true, Time.zone.now],
   [2, false, "와플스튜디오", "asdf@asdf.com",	1,'password', 'password', true, Time.zone.now],
   [3, false, "flyest", "ffffffff@asdf.com", 1, 'password', 'password', true, Time.zone.now],
   [4, false, "korellas", "ttttt@asdf.com", 1, 'password', 'password', true, Time.zone.now],
   [5, false, "이소룡", "asdfasd@asdfasdf.com", 1, 'password', 'password', true, Time.zone.now],
   [6, false, "앙우리", "a@a.com", 1, '11111111', '11111111', true, Time.zone.now]

].each do |x|
  User.create(id: x[0], is_boy: x[1], nickname: x[2], email: x[3], university_id: x[4],
              password: x[5], password_confirmation: x[6], activated: x[7], activated_at: x[8], renew_password: true, skip_activation: true)
end

#admin role for admin@snu.ac.kr
user = User.find(1)
user.add_role('admin')

puts "Inserting lecture data.."
File.read("db/seed_data/lectures.csv").split("\n").each do |line|
  data = line.strip.split(",")
  Lecture.create(
      id: data[0],
      name: data[1],
      university_id: data[3],
      unit: data[4]
  )
end

puts "Inserting professor data.."
File.read("db/seed_data/professors.csv").split("\n").each do |line|
  data = line.strip.split(",")
  Professor.create(
      id: data[0],
      name: data[1],
      university_id: data[2]
  )
end

puts "Inserting course data.."
File.read("db/seed_data/courses.csv").split("\n").each do |line|
  data = line.strip.split(",")
  Course.create(
      id: data[0],
      professor_id: data[1],
      lecture_id: data[2],
      university_id: data[3],
      is_major: data[4]
  )
end

puts "Inserting like data.."
File.read("db/seed_data/likes.csv").split("\n").each do |line|
  data = line.strip.split(",")
  Like.create(
      id: data[0],
      user_id: data[1],
      course_id: data[2],
      is_like: data[4]
  )
end

puts "Inserting evaluation data.."
File.read("db/seed_data/evaluations.csv").split("\n").each do |line|
  data = line.strip.split("\t")
  e = Evaluation.new(
      id: data[0],
      user_id: data[1],
      course_id: data[2],
      like_id: data[0],
      body: data[3]
  )
  unless e.save
    puts e.errors.inspect
  end
end
