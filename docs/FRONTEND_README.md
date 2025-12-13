# 🎟️ RevTickets - Monolithic Ticket Booking Application

## Overview

RevTickets is a comprehensive monolithic web application designed to streamline the process of booking tickets for movies, concerts, sports events, and comedy shows. Built with Angular 18 and designed to integrate with a Spring Boot backend, it provides a unified platform for browsing events, selecting seats, making payments, and managing bookings.

## 🎭 Features

### Public Features (No Login Required)
- **Landing Page**: Browse all event categories with featured events
- **Event Listings**: Filter and search events by category, location, and date
- **Event Details**: View comprehensive event information and show timings

### User Features (Login Required)
- **User Authentication**: Secure login/signup with JWT tokens
- **Interactive Seat Selection**: BookMyShow-style seat selection interface
- **Booking Management**: View booking history and active tickets
- **Profile Management**: Update personal information
- **QR Code Tickets**: Digital tickets with QR codes for entry

### Admin Features
- **Event Management**: Create, update, and delete events
- **Venue Management**: Manage theatres and show timings
- **Analytics Dashboard**: View booking trends and revenue reports
- **User Management**: Monitor user activities and bookings

## 🏗️ Architecture

### Frontend Structure
```
src/app/
├── core/                     # Core services, guards, interceptors
│   ├── guards/              # Auth and admin guards
│   ├── interceptors/        # HTTP interceptors
│   ├── models/             # TypeScript interfaces
│   └── services/           # API services
├── pages/                   # Public pages
│   ├── landing/            # Home page
│   └── events/             # Event listing and details
├── modules/                 # Feature modules
│   ├── auth/               # Login/Register
│   ├── user/               # User dashboard
│   ├── booking-flow/       # Seat selection and booking
│   └── admin/              # Admin panel
└── shared/                  # Reusable components
    └── components/         # Navbar, footer, etc.
```

### Event Categories Supported
- 🎬 **Movies**: Tamil, Hindi, English, Telugu, Malayalam, Kannada + International
- 🎼 **Concerts**: Music festivals, band tours, regional performances
- 🏆 **Sports**: Cricket, Football, Volleyball, Tennis matches
- 😂 **Comedy**: Stand-up comedy specials, regional comedy nights

## 🚀 Getting Started

### Prerequisites
- Node.js (v18 or higher)
- Angular CLI (v18.2.21)
- npm or yarn package manager

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd RevTicket
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start the development server**
   ```bash
   ng serve
   ```

4. **Navigate to the application**
   Open your browser and go to `http://localhost:4200/`

### Backend Integration

This frontend is designed to work with a Spring Boot backend. Update the API URLs in the service files:

```typescript
// In service files, update the apiUrl
private apiUrl = 'http://localhost:8080/api';
```

## 🛠️ Technology Stack

### Frontend
- **Angular 18**: Modern web framework
- **Angular Material**: UI component library
- **RxJS**: Reactive programming
- **TypeScript**: Type-safe JavaScript

### Key Dependencies
- `@angular/material`: Material Design components
- `@angular/cdk`: Component Development Kit
- `qrcode`: QR code generation for tickets
- `rxjs`: Reactive extensions for JavaScript

## 📱 Responsive Design

The application is fully responsive and works seamlessly across:
- Desktop computers
- Tablets
- Mobile phones

## 🔐 Security Features

- **JWT Authentication**: Secure token-based authentication
- **Route Guards**: Protect private routes
- **HTTP Interceptors**: Automatic token attachment
- **Role-based Access**: Different access levels for users and admins

## 🎨 UI/UX Features

- **Material Design**: Clean and modern interface
- **Interactive Seat Maps**: Visual seat selection
- **Real-time Updates**: Live seat availability
- **Toast Notifications**: User feedback system
- **Loading States**: Smooth user experience

## 📊 Data Models

Key interfaces include:
- `User`: User profile and authentication
- `Event`: Movie/concert/sports event details
- `Booking`: Ticket booking information
- `Seat`: Theatre seat layout and pricing
- `Payment`: Transaction details
- `Review`: User reviews and ratings

## 🚦 Routing Structure

```
/                           # Landing page
/login                      # User login
/register                   # User registration
/events/:category           # Event listings by category
/events/:id                 # Event details
/user/dashboard             # User dashboard (protected)
/user/bookings              # User bookings (protected)
/user/profile               # User profile (protected)
/booking/seats/:showId      # Seat selection (protected)
/admin                      # Admin dashboard (admin only)
```

## 🔧 Development Commands

```bash
# Start development server
ng serve

# Build for production
ng build

# Run unit tests
ng test

# Run linting
ng lint

# Generate new component
ng generate component component-name

# Generate new service
ng generate service service-name
```

## 📦 Build and Deployment

### Production Build
```bash
ng build --configuration production
```

The build artifacts will be stored in the `dist/` directory.

### Environment Configuration

Create environment files for different stages:
- `src/environments/environment.ts` (development)
- `src/environments/environment.prod.ts` (production)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the Angular documentation: https://angular.dev
- Check Angular Material documentation: https://material.angular.io

## 🔮 Future Enhancements

- Real-time notifications with WebSockets
- Payment gateway integration
- Social media login
- Mobile app development
- Advanced analytics and reporting
- Multi-language support
- Progressive Web App (PWA) features

---

**Built with ❤️ using Angular 18 and Angular Material**
