package game.model.signal
{
   import idv.cjcat.signals.Signal;
   
   public class PlayerUpdateSignalDispatcher
   {
       
      
      private var _init:Signal;
      
      private var _vip_points:Signal;
      
      private var _vip_level:Signal;
      
      private var _xp:Signal;
      
      private var _nickname:Signal;
      
      private var _level:Signal;
      
      private var _gold:Signal;
      
      private var _stamina:Signal;
      
      private var _starmoney:Signal;
      
      public function PlayerUpdateSignalDispatcher()
      {
         super();
         _init = new Signal();
         _vip_points = new Signal();
         _vip_level = new Signal();
         _xp = new Signal();
         _nickname = new Signal();
         _level = new Signal();
         _gold = new Signal();
         _stamina = new Signal();
         _starmoney = new Signal();
      }
      
      public function get initSignal() : Signal
      {
         return _init;
      }
      
      public function get vip_points() : Signal
      {
         return _vip_points;
      }
      
      public function get vip_level() : Signal
      {
         return _vip_level;
      }
      
      public function get xp() : Signal
      {
         return _xp;
      }
      
      public function get nickname() : Signal
      {
         return _nickname;
      }
      
      public function get level() : Signal
      {
         return _level;
      }
      
      public function get gold() : Signal
      {
         return _gold;
      }
      
      public function get stamina() : Signal
      {
         return _stamina;
      }
      
      public function get starmoney() : Signal
      {
         return _starmoney;
      }
   }
}
