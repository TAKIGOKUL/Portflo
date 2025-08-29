class AppConstants {
  // App Info
  static const String appName = 'Portfolio';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'A responsive portfolio showcasing projects and skills';

  // Personal Info
  static const String name = 'Your Name';
  static const String title = 'Full Stack Developer';
  static const String subtitle = 'Building beautiful and functional applications';
  static const String email = 'your.email@example.com';
  static const String phone = '+1 (555) 123-4567';
  static const String location = 'Your Location';
  
  // Bio
  static const String bio = '''
I'm a passionate full-stack developer with expertise in Flutter, React, Node.js, and cloud technologies. 
I love creating beautiful, responsive applications that provide exceptional user experiences. 
With a strong background in both frontend and backend development, I bring ideas to life through clean, 
efficient code and modern design principles.
''';

  static const String extendedBio = '''
Welcome to my portfolio! I'm a dedicated software developer with over 3 years of experience in building 
scalable web and mobile applications. My journey in tech started with a curiosity about how things work, 
which led me to pursue computer science and eventually specialize in full-stack development.

I have extensive experience with modern frameworks and technologies including Flutter for mobile development, 
React and Next.js for web applications, Node.js and Python for backend services, and cloud platforms like 
AWS and Firebase for deployment and scaling.

What sets me apart is my attention to detail, passion for clean code, and commitment to creating applications 
that not only look great but perform exceptionally well. I believe in continuous learning and staying up-to-date 
with the latest technologies and best practices in software development.

When I'm not coding, you can find me exploring new technologies, contributing to open-source projects, 
or sharing knowledge with the developer community through blog posts and mentoring.
''';

  // Skills
  static const List<String> technicalSkills = [
    'Flutter & Dart',
    'React & Next.js',
    'JavaScript & TypeScript',
    'Node.js & Express',
    'Python & Django',
    'Firebase & AWS',
    'MongoDB & PostgreSQL',
    'Git & DevOps',
    'UI/UX Design',
    'REST APIs & GraphQL',
  ];

  static const List<String> softSkills = [
    'Problem Solving',
    'Team Leadership',
    'Communication',
    'Project Management',
    'Agile Development',
    'Code Review',
    'Mentoring',
    'Creative Thinking',
  ];

  // Social Links
  static const String githubUrl = 'https://github.com/yourusername';
  static const String linkedinUrl = 'https://linkedin.com/in/yourusername';
  static const String twitterUrl = 'https://twitter.com/yourusername';
  static const String portfolioUrl = 'https://yourportfolio.com';
  static const String resumeUrl = 'https://yourresume.com/resume.pdf';
  static const String blogUrl = 'https://yourblog.com';

  // Navigation
  static const List<String> navigationItems = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  // Projects Data
  static const List<Map<String, dynamic>> projects = [
    {
      'id': '1',
      'title': 'E-Commerce Mobile App',
      'description': 'A full-featured e-commerce mobile application built with Flutter, featuring user authentication, product catalog, shopping cart, and payment integration.',
      'longDescription': 'This comprehensive e-commerce solution was built using Flutter for cross-platform mobile development. The app features a modern, intuitive UI with smooth animations and gestures. Key features include user registration and authentication, product browsing with advanced filtering, shopping cart functionality, secure payment processing, order tracking, and an admin panel for inventory management.',
      'technologies': ['Flutter', 'Firebase', 'Stripe', 'Provider', 'REST API'],
      'imageUrl': 'assets/images/project1.jpg',
      'githubUrl': 'https://github.com/yourusername/ecommerce-app',
      'liveUrl': 'https://play.google.com/store/apps/details?id=com.yourapp',
      'category': 'Mobile App',
      'featured': true,
      'status': 'Completed',
      'startDate': '2023-01-01',
      'endDate': '2023-03-01',
      'teamSize': '3 developers',
      'role': 'Lead Flutter Developer',
    },
    {
      'id': '2',
      'title': 'Task Management Web App',
      'description': 'A collaborative task management web application with real-time updates, team collaboration features, and project tracking.',
      'longDescription': 'Built with React and Node.js, this task management platform helps teams organize their work efficiently. Features include drag-and-drop task boards, real-time notifications, team chat, file sharing, time tracking, and comprehensive project analytics. The application uses Socket.io for real-time updates and MongoDB for data persistence.',
      'technologies': ['React', 'Node.js', 'MongoDB', 'Socket.io', 'Material-UI'],
      'imageUrl': 'assets/images/project2.jpg',
      'githubUrl': 'https://github.com/yourusername/task-manager',
      'liveUrl': 'https://taskmanager.yourapp.com',
      'category': 'Web App',
      'featured': true,
      'status': 'Completed',
      'startDate': '2023-04-01',
      'endDate': '2023-06-01',
      'teamSize': '4 developers',
      'role': 'Full Stack Developer',
    },
    {
      'id': '3',
      'title': 'Weather Dashboard',
      'description': 'A responsive weather dashboard with interactive maps, detailed forecasts, and weather alerts.',
      'longDescription': 'This weather application provides comprehensive weather information with a beautiful, intuitive interface. Features include current weather conditions, 7-day forecasts, interactive weather maps, severe weather alerts, location-based services, and historical weather data visualization using Chart.js.',
      'technologies': ['Vue.js', 'Chart.js', 'Weather API', 'Mapbox', 'PWA'],
      'imageUrl': 'assets/images/project3.jpg',
      'githubUrl': 'https://github.com/yourusername/weather-dashboard',
      'liveUrl': 'https://weather.yourapp.com',
      'category': 'Web App',
      'featured': false,
      'status': 'Completed',
      'startDate': '2023-07-01',
      'endDate': '2023-08-01',
      'teamSize': '2 developers',
      'role': 'Frontend Developer',
    },
    {
      'id': '4',
      'title': 'Portfolio Website',
      'description': 'A responsive portfolio website built with Next.js and deployed on Vercel.',
      'longDescription': 'This portfolio website showcases projects and skills with a modern design and smooth animations. Built with Next.js for optimal performance and SEO, featuring dark/light mode toggle, responsive design, contact form with email integration, and blog functionality.',
      'technologies': ['Next.js', 'Tailwind CSS', 'Framer Motion', 'Vercel'],
      'imageUrl': 'assets/images/project4.jpg',
      'githubUrl': 'https://github.com/yourusername/portfolio',
      'liveUrl': 'https://yourportfolio.com',
      'category': 'Website',
      'featured': false,
      'status': 'Completed',
      'startDate': '2023-09-01',
      'endDate': '2023-09-15',
      'teamSize': '1 developer',
      'role': 'Solo Developer',
    },
    {
      'id': '5',
      'title': 'Fitness Tracking App',
      'description': 'A comprehensive fitness tracking mobile app with workout plans, progress tracking, and social features.',
      'longDescription': 'This fitness application helps users track their workouts, monitor progress, and connect with other fitness enthusiasts. Features include customizable workout plans, exercise library with video demonstrations, progress charts, social feed, challenges, and integration with wearable devices.',
      'technologies': ['React Native', 'Firebase', 'Redux', 'Health Kit', 'Charts'],
      'imageUrl': 'assets/images/project5.jpg',
      'githubUrl': 'https://github.com/yourusername/fitness-app',
      'liveUrl': 'https://apps.apple.com/us/app/yourfitnessapp',
      'category': 'Mobile App',
      'featured': true,
      'status': 'In Development',
      'startDate': '2023-10-01',
      'endDate': '2024-01-01',
      'teamSize': '5 developers',
      'role': 'Mobile Developer',
    },
    {
      'id': '6',
      'title': 'Learning Management System',
      'description': 'An educational platform with course management, student tracking, and interactive learning modules.',
      'longDescription': 'This comprehensive LMS platform serves educational institutions and online course creators. Features include course creation tools, student enrollment and tracking, interactive quizzes and assignments, video streaming, progress analytics, certificate generation, and payment processing for course sales.',
      'technologies': ['Django', 'React', 'PostgreSQL', 'Redis', 'AWS S3'],
      'imageUrl': 'assets/images/project6.jpg',
      'githubUrl': 'https://github.com/yourusername/lms-platform',
      'liveUrl': 'https://lms.yourapp.com',
      'category': 'Web Platform',
      'featured': false,
      'status': 'Completed',
      'startDate': '2022-06-01',
      'endDate': '2022-12-01',
      'teamSize': '6 developers',
      'role': 'Backend Developer',
    },
  ];

  // Experience Data
  static const List<Map<String, dynamic>> experiences = [
    {
      'id': '1',
      'company': 'Tech Solutions Inc.',
      'position': 'Senior Flutter Developer',
      'startDate': '2022-01-01',
      'endDate': null, // Current position
      'location': 'Remote',
      'description': 'Leading mobile app development projects using Flutter. Mentoring junior developers and establishing best practices for code quality and app architecture.',
      'achievements': [
        'Led development of 3 major mobile applications',
        'Improved app performance by 40% through optimization',
        'Mentored 5 junior developers',
        'Established CI/CD pipeline for mobile deployments',
      ],
      'technologies': ['Flutter', 'Dart', 'Firebase', 'AWS', 'Git'],
    },
    {
      'id': '2',
      'company': 'Digital Agency Pro',
      'position': 'Full Stack Developer',
      'startDate': '2020-06-01',
      'endDate': '2021-12-31',
      'location': 'New York, NY',
      'description': 'Developed web applications using React, Node.js, and various databases. Collaborated with design teams to implement pixel-perfect user interfaces.',
      'achievements': [
        'Built 15+ responsive web applications',
        'Reduced page load times by 35%',
        'Implemented automated testing reducing bugs by 50%',
        'Collaborated with UI/UX team on 20+ projects',
      ],
      'technologies': ['React', 'Node.js', 'MongoDB', 'PostgreSQL', 'AWS'],
    },
    {
      'id': '3',
      'company': 'StartupXYZ',
      'position': 'Frontend Developer',
      'startDate': '2019-03-01',
      'endDate': '2020-05-31',
      'location': 'San Francisco, CA',
      'description': 'Focused on creating engaging user interfaces and optimizing user experience for a growing SaaS platform.',
      'achievements': [
        'Implemented responsive design for 10+ components',
        'Increased user engagement by 25%',
        'Built reusable component library',
        'Conducted user testing sessions',
      ],
      'technologies': ['JavaScript', 'Vue.js', 'SCSS', 'Figma'],
    },
  ];

  // Education Data
  static const List<Map<String, dynamic>> education = [
    {
      'id': '1',
      'institution': 'University of Technology',
      'degree': 'Bachelor of Science in Computer Science',
      'startDate': '2015-09-01',
      'endDate': '2019-05-31',
      'location': 'Your City, State',
      'gpa': '3.8/4.0',
      'coursework': [
        'Data Structures and Algorithms',
        'Software Engineering',
        'Database Systems',
        'Web Development',
        'Mobile App Development',
        'Computer Networks',
      ],
      'achievements': [
        'Dean\'s List for 4 semesters',
        'Computer Science Student of the Year 2019',
        'President of Programming Club',
        'Published research on mobile app optimization',
      ],
    },
  ];

  // Certifications
  static const List<Map<String, dynamic>> certifications = [
    {
      'id': '1',
      'name': 'AWS Certified Solutions Architect',
      'issuer': 'Amazon Web Services',
      'date': '2023-03-15',
      'credentialId': 'AWS-SA-123456',
      'url': 'https://aws.amazon.com/certification/',
    },
    {
      'id': '2',
      'name': 'Google Flutter Certified Developer',
      'issuer': 'Google',
      'date': '2022-11-20',
      'credentialId': 'FLUTTER-456789',
      'url': 'https://developers.google.com/certification',
    },
    {
      'id': '3',
      'name': 'MongoDB Certified Developer',
      'issuer': 'MongoDB University',
      'date': '2022-08-10',
      'credentialId': 'MONGO-789012',
      'url': 'https://university.mongodb.com/certification',
    },
  ];

  // Contact Form Fields
  static const List<String> contactFormFields = [
    'name',
    'email',
    'subject',
    'message',
  ];

  // Animation Durations (in milliseconds)
  static const int shortAnimationDuration = 300;
  static const int mediumAnimationDuration = 500;
  static const int longAnimationDuration = 800;

  // API Endpoints (if using external APIs)
  static const String baseApiUrl = 'https://api.yourbackend.com';
  static const String contactApiEndpoint = '/api/contact';
  static const String analyticsEndpoint = '/api/analytics';

  // Storage Keys
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
  static const String firstLaunchKey = 'first_launch';

  // Asset Paths
  static const String imagesPath = 'assets/images/';
  static const String iconsPath = 'assets/icons/';
  static const String animationsPath = 'assets/animations/';
  static const String fontsPath = 'assets/fonts/';

  // File Names
  static const String profileImage = 'profile.jpg';
  static const String logoImage = 'logo.png';
  static const String backgroundImage = 'background.jpg';
  static const String resumePdf = 'resume.pdf';

  // URLs and Links
  static const String privacyPolicyUrl = 'https://yourapp.com/privacy';
  static const String termsOfServiceUrl = 'https://yourapp.com/terms';
  static const String supportEmail = 'support@yourapp.com';

  // Feature Flags
  static const bool enableAnalytics = true;
  static const bool enablePushNotifications = false;
  static const bool enableOfflineMode = true;
  static const bool enableDarkMode = true;
}
