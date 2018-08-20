package game.model.user.titansummoningcircle
{
   import idv.cjcat.signals.Signal;
   
   public class PlayerTitanSummoningCircle
   {
       
      
      private var _starmoneySpent:uint;
      
      private var _signal_starmoneySpent:Signal;
      
      public function PlayerTitanSummoningCircle()
      {
         _signal_starmoneySpent = new Signal();
         super();
      }
      
      public function get starmoneySpent() : uint
      {
         return _starmoneySpent;
      }
      
      public function set starmoneySpent(param1:uint) : void
      {
         _starmoneySpent = param1;
         _signal_starmoneySpent.dispatch();
      }
      
      public function get signal_starmoneySpent() : Signal
      {
         return _signal_starmoneySpent;
      }
      
      public function initialize(param1:Object) : void
      {
         _starmoneySpent = param1.starmoneySpent;
      }
      
      public function update(param1:Object) : void
      {
         starmoneySpent = param1.starmoneySpent;
      }
   }
}
