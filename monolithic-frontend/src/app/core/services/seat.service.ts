import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Seat } from '../models/seat.model';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class SeatService {
  private apiUrl = `${environment.apiUrl}/seats`;

  constructor(private http: HttpClient) {}

  getSeatsByShowId(showId: number): Observable<Seat[]> {
    return this.http.get<Seat[]>(`${this.apiUrl}/show/${showId}`);
  }

  generateSeats(showId: number, totalSeats: number): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/generate/${showId}/${totalSeats}`, {});
  }

  getSeatLayout(showId: string): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/show/${showId}`);
  }

  selectSeat(seat: Seat): void {}
  deselectSeat(id: any): void {}
  clearSelection(): void {}
  selectedSeats$ = { subscribe: (fn: any) => {} };
}
