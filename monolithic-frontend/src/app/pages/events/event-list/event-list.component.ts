import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatIconModule } from '@angular/material/icon';
import { FormsModule } from '@angular/forms';
import { EventService } from '../../../core/services/event.service';
import { Event } from '../../../core/models/event.model';

@Component({
  selector: 'app-event-list',
  standalone: true,
  imports: [CommonModule, RouterModule, MatCardModule, MatButtonModule, MatFormFieldModule, MatInputModule, MatIconModule, FormsModule],
  template: `
    <div class="event-list-container">

      <div class="header">
        <h1>{{categoryTitle}}</h1>
        <div class="filters">
          <div class="location-selector">
            <mat-icon>location_on</mat-icon>
            <select [(ngModel)]="selectedLocation" (change)="onLocationFilter()">
              <option value="">All Locations</option>
              <option *ngFor="let location of locations" [value]="location">{{location}}</option>
            </select>
          </div>
          <div class="search-bar">
            <mat-icon>search</mat-icon>
            <input [(ngModel)]="searchQuery" (input)="onSearch()" placeholder="Search by title, genre">
          </div>
        </div>
      </div>

      <div class="events-grid" *ngIf="events.length > 0">
        <mat-card *ngFor="let event of filteredEvents" class="event-card" 
                  [routerLink]="['/events/details', event.id]">
          <img mat-card-image [src]="event.posterUrl" [alt]="event.title">
          <mat-card-header>
            <mat-card-title>{{event.title}}</mat-card-title>
            <mat-card-subtitle>{{event.language}} | {{event.genreOrType}}</mat-card-subtitle>
          </mat-card-header>
          <mat-card-content>
            <p><strong>{{event.city}}</strong> - {{event.venue}}</p>
            <p>₹{{event.price}} onwards</p>
            <div *ngIf="event.rating" class="rating">
              ⭐ {{event.rating}}/5
            </div>
          </mat-card-content>
          <mat-card-actions>
            <button mat-raised-button color="primary">Book Now</button>
          </mat-card-actions>
        </mat-card>
      </div>

      <div *ngIf="events.length === 0" class="no-events">
        <p>No events found in this category.</p>
      </div>
    </div>
  `,
  styles: [`
    .event-list-container {
      padding: 32px 20px;
      min-height: 100vh;
      max-width: 1400px;
      margin: 0 auto;
    }

    .header {
      margin-bottom: 40px;
    }
    
    .header h1 {
      font-size: clamp(1.75rem, 4vw, 2.5rem);
      font-weight: 800;
      background: var(--primary-gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      letter-spacing: -0.02em;
      margin: 0 0 20px 0;
    }
    
    .filters {
      display: flex;
      gap: 16px;
      align-items: center;
      flex-wrap: wrap;
    }
    
    .location-selector {
      display: flex;
      align-items: center;
      gap: 12px;
      background: white;
      padding: 12px 20px;
      border-radius: var(--radius-md);
      border: 1px solid var(--border-color);
      box-shadow: var(--shadow-md);
      transition: all var(--transition-normal);
    }
    
    .location-selector:hover {
      border-color: var(--primary-color);
      box-shadow: var(--shadow-lg);
    }
    
    .location-selector mat-icon {
      color: var(--primary-color);
      font-size: 24px;
    }
    
    .location-selector select {
      border: none;
      background: transparent;
      font-size: 16px;
      font-weight: 600;
      color: var(--text-primary);
      cursor: pointer;
      outline: none;
      padding: 4px 8px;
    }
    
    .search-bar {
      display: flex;
      align-items: center;
      gap: 12px;
      background: white;
      padding: 12px 20px;
      border-radius: var(--radius-md);
      border: 1px solid var(--border-color);
      box-shadow: var(--shadow-md);
      flex: 1;
      transition: all var(--transition-normal);
    }
    
    .search-bar:hover {
      border-color: var(--primary-color);
      box-shadow: var(--shadow-lg);
    }
    
    .search-bar mat-icon {
      color: var(--primary-color);
      font-size: 24px;
    }
    
    .search-bar input {
      border: none;
      background: transparent;
      font-size: 16px;
      color: var(--text-primary);
      outline: none;
      flex: 1;
      font-weight: 500;
    }
    
    .search-bar input::placeholder {
      color: var(--text-muted);
    }
    .events-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
      gap: 24px;
    }
    
    .event-card {
      cursor: pointer;
      transition: all var(--transition-normal);
      border-radius: var(--radius-lg);
      overflow: hidden;
      background: var(--card-bg);
      border: 1px solid var(--border-color);
      box-shadow: var(--shadow-md);
    }
    
    .event-card:hover {
      transform: translateY(-6px);
      box-shadow: var(--shadow-xl);
      border-color: var(--primary-color);
    }
    .event-card img {
      height: 300px;
      object-fit: cover;
      width: 100%;
      transition: transform var(--transition-slow);
    }
    
    .event-card:hover img {
      transform: scale(1.05);
    }
    
    .event-card mat-card-header {
      padding: 16px;
    }
    
    .event-card mat-card-title {
      color: var(--text-primary);
      font-size: 15px;
      font-weight: 700;
      margin: 0;
      letter-spacing: -0.01em;
    }
    
    .event-card mat-card-subtitle {
      color: var(--text-secondary);
      font-size: 13px;
      margin: 6px 0 0;
      font-weight: 500;
    }
    
    .event-card mat-card-content {
      padding: 0 16px 16px;
      color: var(--text-secondary);
      font-size: 13px;
    }
    
    .rating {
      display: inline-block;
      padding: 6px 12px;
      background: linear-gradient(135deg, #ffa726, #ff9800);
      color: white;
      border-radius: var(--radius-md);
      font-size: 12px;
      font-weight: 700;
      box-shadow: var(--shadow-sm);
    }
    .no-events {
      text-align: center;
      padding: 80px 40px;
      background: white;
      border-radius: var(--radius-xl);
      border: 1px solid var(--border-color);
      box-shadow: var(--shadow-md);
    }
    
    .no-events p {
      color: var(--text-secondary);
      font-size: 16px;
    }
    
    @media (max-width: 768px) {
      .event-list-container {
        padding: 24px 16px;
      }
      
      .filters {
        flex-direction: column;
      }
      
      .location-selector,
      .search-bar {
        width: 100%;
      }
      
      .events-grid {
        gap: 20px;
      }
    }
  `]
})
export class EventListComponent implements OnInit {
  events: Event[] = [];
  filteredEvents: Event[] = [];
  allEvents: Event[] = [];
  searchQuery = '';
  category = '';
  categoryTitle = '';
  selectedLocation = '';
  locations: string[] = [];

  constructor(
    private eventService: EventService,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    this.route.params.subscribe(params => {
      console.log('Route params:', params);
      this.category = params['category'];
      console.log('Category:', this.category);
      this.categoryTitle = this.getCategoryTitle(this.category);
      this.loadEvents();
    });
  }

  private loadEvents(): void {
    console.log('Loading events for category:', this.category);
    if (this.category) {
      this.eventService.getEventsByCategory(this.category).subscribe({
        next: (events) => {
          console.log('Events loaded:', events.length);
          this.allEvents = events.reverse();
          this.events = this.allEvents;
          this.filteredEvents = this.allEvents;
          this.locations = [...new Set(events.map(e => e.city).filter(c => c))];
        },
        error: (error) => {
          console.error('Error loading events:', error);
          console.log('Category that failed:', this.category);
        }
      });
    } else {
      this.eventService.getAllEvents().subscribe({
        next: (events) => {
          console.log('All events loaded:', events.length);
          this.allEvents = events.reverse();
          this.events = this.allEvents;
          this.filteredEvents = this.allEvents;
          this.locations = [...new Set(events.map(e => e.city).filter(c => c))];
        },
        error: (error) => console.error('Error loading events:', error)
      });
    }
  }

  onLocationFilter(): void {
    if (this.selectedLocation) {
      this.events = this.allEvents.filter(e => e.city === this.selectedLocation);
    } else {
      this.events = this.allEvents;
    }
    this.onSearch();
  }

  onSearch(): void {
    if (!this.searchQuery.trim()) {
      this.filteredEvents = this.events;
      return;
    }

    const query = this.searchQuery.toLowerCase();
    this.filteredEvents = this.events.filter(event =>
      event.title.toLowerCase().includes(query) ||
      event.genreOrType.toLowerCase().includes(query) ||
      (event.city && event.city.toLowerCase().includes(query)) ||
      (event.venue && event.venue.toLowerCase().includes(query))
    );
  }

  private getCategoryTitle(category: string): string {
    const titles: { [key: string]: string } = {
      'movies': '🎬 Movies',
      'concerts': 'Concerts',
      'sports': 'Sports',
      'comedy': 'Comedy Shows'
    };
    return titles[category] || 'All Events';
  }
}