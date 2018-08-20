package game.mechanics.clientoffer.storage
{
   public class ClientOfferBillingBonusReminderDescription
   {
       
      
      private var _duration:Number;
      
      private var _delay:Number;
      
      private var _ident:String;
      
      private var _teamLevel:int;
      
      private var _timesPerSession:int;
      
      private var _enableEvent:String;
      
      private var _enableWindowChance:Object;
      
      private var _disableEvent:String;
      
      private var _disableEventData:String;
      
      private var _view:Object;
      
      private var _billingSale:String;
      
      public function ClientOfferBillingBonusReminderDescription(param1:Object)
      {
         super();
         this._duration = param1.duration;
         this._delay = param1.delay;
         this._ident = param1.ident;
         this._teamLevel = param1.teamLevel;
         this._timesPerSession = param1.timesPerSession;
         this._enableEvent = param1.enableEvent;
         this._enableWindowChance = param1.enableWindowChance;
         this._disableEvent = param1.disableEvent;
         this._disableEventData = param1.disableEventData;
         this._view = param1.view;
         this._billingSale = param1.billingSale;
      }
      
      public function get duration() : Number
      {
         return _duration;
      }
      
      public function get delay() : Number
      {
         return _delay;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      public function get teamLevel() : Number
      {
         return _teamLevel;
      }
      
      public function get timesPerSession() : Number
      {
         return _timesPerSession;
      }
      
      public function get enableEvent() : String
      {
         return _enableEvent;
      }
      
      public function get disableEvent() : String
      {
         return _disableEvent;
      }
      
      public function get disableEventData() : String
      {
         return _disableEventData;
      }
      
      public function get view() : Object
      {
         return _view;
      }
      
      public function get billingSale() : String
      {
         return _billingSale;
      }
      
      public function getEnabledWindowChance(param1:String) : Number
      {
         return Number(_enableWindowChance[param1]);
      }
      
      public function getEnableWindowData() : Vector.<String>
      {
         var _loc2_:Vector.<String> = new Vector.<String>();
         var _loc4_:int = 0;
         var _loc3_:* = _enableWindowChance;
         for(var _loc1_ in _enableWindowChance)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
   }
}
