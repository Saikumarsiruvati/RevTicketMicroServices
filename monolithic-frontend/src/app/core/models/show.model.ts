export interface Show {
  id?: number;
  eventId: number;
  venueId: number;
  showTime: string;
  availableSeats: number;
  isActive?: boolean;
  event?: any;
}
