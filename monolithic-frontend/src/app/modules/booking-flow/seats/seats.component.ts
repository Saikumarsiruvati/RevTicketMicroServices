import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { SeatService } from '../../../core/services/seat.service';
import { BookingService } from '../../../core/services/booking.service';
import { Seat } from '../../../core/models/seat.model';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-seats',
  standalone: true,
  imports: [CommonModule, MatCardModule, MatButtonModule, MatIconModule, MatSnackBarModule],
  template: `
    <div class="seats-container">
      <div class="screen-section">
        <div class="screen">SCREEN</div>
      </div>

      <div class="seat-layout" *ngIf="seatLayout">
        <div *ngFor="let category of ['Regular', 'Silver', 'Gold', 'Premium']" class="category-section">
          <ng-container *ngIf="getCategoryRows(category).length > 0">
            <div class="category-header">
              <h3>{{category}} - ₹{{getPriceByCategory(category)}}</h3>
              <span class="available-count">{{getAvailableSeatsCount(category)}} Available</span>
            </div>
            <div class="category-rows">
              <ng-container *ngFor="let row of getCategoryRows(category)">
                <div class="seat-row">
                  <div class="row-label">{{row.rowName}}</div>
                  <div class="seats">
                    <ng-container *ngFor="let seat of row.seats; let i = index">
                      <div class="seat" 
                           [class]="getSeatClass(seat)"
                           (click)="toggleSeat(seat)"
                           [title]="seat.seatNumber">
                        {{seat.number}}
                      </div>
                      <div *ngIf="i === 9" class="aisle-gap"></div>
                    </ng-container>
                  </div>
                </div>
              </ng-container>
            </div>
          </ng-container>
        </div>
      </div>

      <div class="legend">
        <div class="legend-item">
          <div class="seat available"></div>
          <span>Available</span>
        </div>
        <div class="legend-item">
          <div class="seat selected"></div>
          <span>Selected</span>
        </div>
        <div class="legend-item">
          <div class="seat booked"></div>
          <span>Booked</span>
        </div>
      </div>

      <div class="booking-summary" *ngIf="selectedSeats.length > 0">
        <mat-card>
          <mat-card-header>
            <mat-card-title>Booking Summary</mat-card-title>
          </mat-card-header>
          <mat-card-content>
            <div class="selected-seats">
              <h4>Selected Seats ({{selectedSeats.length}})</h4>
              <div class="seat-list">
                <span *ngFor="let seat of selectedSeats" class="seat-tag">
                  {{seat.seatNumber}} ({{seat.seatType}})
                </span>
              </div>
            </div>
            <div class="price-breakdown">
              <div class="price-item" *ngFor="let category of getPriceBreakdown()">
                <span>{{category.name}} ({{category.count}} × ₹{{category.price}})</span>
                <span>₹{{category.total}}</span>
              </div>
              <div class="total-price">
                <strong>Total: ₹{{getTotalPrice()}}</strong>
              </div>
            </div>
          </mat-card-content>
          <mat-card-actions>
            <button mat-raised-button color="primary" 
                    [disabled]="selectedSeats.length === 0"
                    (click)="proceedToPayment()">
              Proceed to Payment
            </button>
            <button mat-button class="clear-btn" (click)="clearSelection()">Clear Selection</button>
          </mat-card-actions>
        </mat-card>
      </div>
    </div>
  `,
  styles: [`
    .seats-container {
      padding: 20px;
      max-width: 1000px;
      margin: 0 auto;
      background: var(--primary-bg);
      min-height: 100vh;
    }
    .screen-section { 
      text-align: center; 
      margin-bottom: 40px;
    }
    .screen {
      background: #f5f5f5;
      color: #333;
      padding: 10px 80px;
      border-radius: 8px;
      display: inline-block;
      font-weight: 600;
      margin-bottom: 20px;
      border: 2px solid #ddd;
      font-size: 14px;
      letter-spacing: 2px;
    }

    .seat-layout {
      margin-bottom: 24px;
      background: var(--card-bg);
      padding: 24px;
      border-radius: var(--radius-lg);
      border: 1px solid var(--border-color);
      box-shadow: var(--shadow-md);
    }
    .category-section {
      margin-bottom: 45px;
      padding-bottom: 25px;
      border-bottom: 2px solid var(--border-color);
    }
    .category-section:last-child {
      margin-bottom: 0;
      border-bottom: none;
      padding-bottom: 0;
    }
    .category-header {
      padding: 12px 0;
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 16px;
      border-bottom: 2px solid var(--border-color);
    }
    .category-header h3 {
      margin: 0;
      color: var(--text-primary);
      font-size: 16px;
      font-weight: 600;
    }
    .available-count {
      color: #4caf50;
      font-size: 14px;
      font-weight: 500;
    }
    .category-rows {
      padding: 0;
      display: flex;
      flex-direction: column;
      width: 100%;
    }
    .seat-row { 
      display: flex; 
      align-items: center; 
      margin-bottom: 8px;
      justify-content: center;
      width: 100%;
    }
    .row-label { 
      width: 25px; 
      font-weight: 600; 
      text-align: right;
      color: var(--text-primary);
      font-size: 12px;
      margin-right: 20px;
    }
    .seats { 
      display: flex; 
      gap: 5px;
      flex-wrap: nowrap;
      align-items: center;
    }
    .aisle-gap {
      width: 30px;
      height: 1px;
    }
    .seat {
      width: 35px;
      height: 35px;
      border: 2px solid #ddd;
      border-radius: 4px;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      font-size: 10px;
      font-weight: 600;
      transition: all 0.2s ease;
      background: #fff;
      color: #333;
    }
    .seat.available {
      background: #4CAF50;
      border-color: #4CAF50;
      color: white;
    }
    .seat.available:hover {
      background: #45a049;
      transform: scale(1.05);
    }
    .seat.selected {
      background: #2196F3;
      color: white;
      border-color: #2196F3;
      transform: scale(1.1);
    }

    .seat.booked {
      background: #9e9e9e;
      border-color: #9e9e9e;
      cursor: not-allowed;
      color: #fff;
      opacity: 0.5;
    }
    .seat.locked {
      background: #ff9800;
      border-color: #ff9800;
      cursor: not-allowed;
      color: white;
    }

    .legend { display: flex; gap: 20px; justify-content: center; margin-bottom: 30px; }
    .legend-item { display: flex; align-items: center; gap: 8px; }
    .booking-summary {
      position: sticky;
      bottom: 20px;
    }
    .booking-summary .mat-mdc-card {
      background: var(--card-bg);
      border: 2px solid var(--primary-color);
      color: var(--text-primary);
      box-shadow: var(--shadow-xl), var(--shadow-glow);
    }
    .booking-summary .mat-mdc-card-header .mat-mdc-card-title {
      color: var(--primary-color);
      font-weight: 700;
    }
    .booking-summary .mat-mdc-card-content h4 {
      color: var(--text-primary);
      margin-bottom: 12px;
    }

    .seat-list { display: flex; flex-wrap: wrap; gap: 8px; margin: 10px 0; }
    .seat-tag { 
      background: var(--primary-gradient); 
      color: white;
      padding: 6px 12px; 
      border-radius: var(--radius-md); 
      font-size: 12px;
      font-weight: 600;
      box-shadow: var(--shadow-sm);
    }
    .price-breakdown { margin-top: 15px; }
    .price-item { 
      display: flex; 
      justify-content: space-between; 
      margin: 8px 0;
      color: var(--text-secondary);
      font-size: 14px;
    }
    .total-price { 
      border-top: 2px solid var(--primary-color); 
      padding-top: 12px; 
      margin-top: 15px; 
      display: flex; 
      justify-content: space-between;
      color: var(--text-primary);
      font-size: 16px;
      font-weight: 700;
    }
    .clear-btn {
      color: var(--text-secondary) !important;
    }
    .clear-btn:hover {
      background-color: var(--card-hover) !important;
      color: var(--text-primary) !important;
    }
  `]
})
export class SeatsComponent implements OnInit, OnDestroy {
  showId = '';
  seatLayout: any = null;
  selectedSeats: Seat[] = [];
  private subscription = new Subscription();

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private seatService: SeatService,
    private bookingService: BookingService,
    private snackBar: MatSnackBar
  ) {}

  ngOnInit(): void {
    this.showId = this.route.snapshot.params['showId'];
    this.loadSeatLayout();
    
    // Subscription removed - using local state
  }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
    this.seatService.clearSelection();
  }

  private loadSeatLayout(): void {
    this.seatService.getSeatsByShowId(Number(this.showId)).subscribe({
      next: (seats) => {
        this.seatLayout = this.createLayoutFromSeats(seats);
      },
      error: (error) => {
        console.error('Error loading seat layout:', error);
        this.snackBar.open('Error loading seats', 'Close', { duration: 3000 });
      }
    });
  }

  private createLayoutFromSeats(seats: Seat[]): any {
    const rowMap: any = {};
    
    seats.forEach(seat => {
      const rowLetter = seat.seatNumber.charAt(0);
      const seatNumber = parseInt(seat.seatNumber.substring(1));
      const category = seat.seatType || 'Regular';
      
      if (!rowMap[rowLetter]) {
        rowMap[rowLetter] = {
          rowName: rowLetter,
          category: category,
          seats: []
        };
      }
      
      rowMap[rowLetter].seats.push({
        ...seat,
        row: rowLetter,
        number: seatNumber,
        category: category,
        price: seat.price || this.getPriceByCategory(category),
        status: seat.isBooked ? 'BOOKED' : (seat.status || 'AVAILABLE')
      });
    });
    
    const rows = Object.values(rowMap);
    rows.forEach((row: any) => {
      row.seats.sort((a: any, b: any) => a.number - b.number);
    });
    
    rows.sort((a: any, b: any) => a.rowName.localeCompare(b.rowName));
    
    return { rows };
  }
  
  getPriceByCategory(category: string): number {
    const prices: any = {
      'Regular': 150,
      'Silver': 200,
      'Gold': 250,
      'Premium': 300
    };
    return prices[category] || 150;
  }

  getPrice(seat: any): number {
    return seat.price || this.getPriceByCategory(seat.seatType || seat.category || 'Regular');
  }

  getSeatClass(seat: Seat): string {
    if (seat.status === 'BOOKED') return 'booked';
    if (seat.status === 'BLOCKED') return 'locked';
    if (this.selectedSeats.find(s => s.id === seat.id)) return 'selected';
    return 'available';
  }

  toggleSeat(seat: Seat): void {
    if (seat.status === 'BOOKED' || seat.status === 'BLOCKED') {
      return;
    }

    const index = this.selectedSeats.findIndex(s => s.id === seat.id);
    if (index > -1) {
      this.selectedSeats.splice(index, 1);
    } else {
      if (this.selectedSeats.length >= 5) {
        this.snackBar.open('Maximum 5 seats can be selected', 'Close', { duration: 3000 });
        return;
      }
      this.selectedSeats.push(seat);
    }
  }

  getPriceBreakdown(): any[] {
    const breakdown: { [key: string]: { count: number; price: number } } = {};
    
    this.selectedSeats.forEach(seat => {
      const category = seat.seatType || 'Regular';
      const price = seat.price || 100;
      if (!breakdown[category]) {
        breakdown[category] = { count: 0, price: price };
      }
      breakdown[category].count++;
    });

    return Object.entries(breakdown).map(([name, data]) => ({
      name,
      count: data.count,
      price: data.price,
      total: data.count * data.price
    }));
  }

  getTotalPrice(): number {
    return this.selectedSeats.reduce((total, seat) => total + this.getPrice(seat), 0);
  }

  getCategoryRows(category: string): any[] {
    if (!this.seatLayout) return [];
    return this.seatLayout.rows.filter((row: any) => row.category === category);
  }
  
  getAvailableSeatsCount(category: string): number {
    const rows = this.getCategoryRows(category);
    let count = 0;
    rows.forEach((row: any) => {
      count += row.seats.filter((seat: any) => seat.status === 'AVAILABLE').length;
    });
    return count;
  }

  clearSelection(): void {
    this.selectedSeats = [];
  }

  proceedToPayment(): void {
    // Store selected seats in sessionStorage
    sessionStorage.setItem('selectedSeats', JSON.stringify(this.selectedSeats));
    this.router.navigate(['/booking/checkout'], {
      queryParams: { showId: this.showId }
    });
  }
}