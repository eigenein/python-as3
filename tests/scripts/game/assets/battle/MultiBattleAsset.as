package game.assets.battle
{
   import engine.core.assets.AssetProvider;
   import engine.core.assets.FileDependentAsset;
   
   public class MultiBattleAsset extends FileDependentAsset
   {
       
      
      protected var _completed:Boolean;
      
      private var battles:Array;
      
      public function MultiBattleAsset()
      {
         battles = [];
         super();
      }
      
      override public function get completed() : Boolean
      {
         return _completed;
      }
      
      public function addBattle(param1:BattleAsset) : void
      {
         battles.push(param1);
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         battles.unshift(this);
         param1.request.apply(null,battles);
         battles.shift();
      }
      
      override public function complete() : void
      {
         _completed = true;
      }
   }
}
