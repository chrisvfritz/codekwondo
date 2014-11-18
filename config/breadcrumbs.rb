crumb :courses do
  link 'Home', root_path
end

# Removing this for now until other people want to create their own courses
# crumb :courses do
#   link 'Courses', courses_path
#   parent :root
# end

crumb :course do |course|
  link "Course: #{course.title}", course
  parent :courses
end

# crumb :course_skills do |course|
#   link 'Skills', course_skills_path(course)
#   parent course
# end

crumb :skill do |skill|
  link "Skill: #{skill.title}", skill
  parent skill.course
end

crumb :new_course_skill do |course|
  link 'New Skill', new_course_skill_path(course)
  parent course
end

# crumb :skill_resources do |skill|
#   link 'Resources', skill_resources_path(skill)
#   parent skill
# end

crumb :resource do |resource|
  link "Resource: #{resource.title}", resource
  parent resource.skill
end

crumb :new_skill_resource do |skill|
  link 'New Resource', new_skill_resource_path(skill)
  parent skill
end

crumb :project do |project|
  link "Project: #{project.title}", project
  parent project.skill
end

crumb :new_skill_project do |skill|
  link 'New Project', new_skill_project_path(skill)
  parent skill
end

crumb :project_completion do |completion|
  link 'Showcase', project_completion_path(completion)
  parent completion.project
end

crumb :new_project_completion do |project|
  link 'New Showcase', new_project_project_completion_path(project)
  parent project
end