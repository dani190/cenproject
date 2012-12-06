# Seed File, create departments and students
departments = Department.create([ { name: 'Academics and Learning', desk: '1' }, 
                                  { name: 'Admissions', desk: '2' }, 
                                  { name: 'Athletics and Recreation', desk: '3' }, 
                                  { name: 'Campus Life', desk: '4' }, 
                                  { name: 'Campus Services', desk: '5' }, 
                                  { name: 'Clubs and Associations', desk: '6' }, 
                                  { name: 'Co-op Programs', desk: '7' }, 
                                  { name: 'Employment Resources', desk: '8' }, 
                                  { name: 'Financial Aid', desk: '9' }, 
                                  { name: 'Parking and Transportation', desk: '10' }, 
                                  { name: 'Programs and Courses', desk: '11' }, 
                                  { name: 'Security', desk: '12' }, 
                                  { name: 'Student Advising', desk: '13' }, 
                                  { name: 'Technical Support', desk: '14' }
                                ])
                                
admins = Admin.create([ { email: 'admin@cencol.com', password: 'eb-5052jj' } ])

students = Student.create([ { first_name: 'Adam', last_name: 'Chow', student_number: '6046465681727697', phone_number: '4168295958', pushover_id: 'OF6vKP5j68r4363TdtQCXRx89KMunp'},
                            { first_name: 'Dani', last_name: 'Cela', student_number: '6046466958048387', phone_number: '4169088039', pushover_id: 'HApzXh9iugkKuYGvRE4ejvZiv356aA'},
                            { first_name: 'Talveen', last_name: 'Labana', student_number: '6046469541518650', phone_number: '4162012779', pushover_id: ''},
                            { first_name: 'Nadim', last_name: 'Remtula', student_number: '6046468715249712', phone_number: '4169172522', pushover_id: ''},
                            { first_name: 'Marc', last_name: 'Niculescu', student_number: '6046465681727696', phone_number: '4168295958', pushover_id: ''},
                            { first_name: 'Jeremy', last_name: 'Gabriel', student_number: '6046465681727697', phone_number: '4168295958', pushover_id: ''},
                            { first_name: 'Will', last_name: 'Barker', student_number: '6046465681727691', phone_number: '4168295958', pushover_id: ''},
                            { first_name: 'CAA', last_name: 'Plus', student_number: '6202825924539003', phone_number: '', pushover_id: 'HApzXh9iugkKuYGvRE4ejvZiv356aA'},
                            { first_name: 'Esso', last_name: 'Extra', student_number: '601777352515230234', phone_number: '', pushover_id: 'HApzXh9iugkKuYGvRE4ejvZiv356aA'}
                          ])