package game.battle.view.systems
{
   import engine.core.utils.VectorUtil;
   import game.battle.view.BattleSceneObject;
   
   public class BattleUpdateSystem
   {
       
      
      protected var type:Class;
      
      private var _collection:Vector.<*>;
      
      public function BattleUpdateSystem(param1:Class)
      {
         super();
         this.type = param1;
         _collection = this.collection;
      }
      
      protected function get collection() : Vector.<*>
      {
         return null;
      }
      
      public function getComponentToHandle(param1:BattleSceneObject) : *
      {
         return param1 as type;
      }
      
      public function add(param1:*) : void
      {
         _collection.push(param1);
      }
      
      public function remove(param1:*) : void
      {
         VectorUtil.remove(_collection,param1);
      }
      
      public function advanceTime(param1:Number) : void
      {
      }
   }
}
