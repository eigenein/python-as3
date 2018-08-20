package game.mechanics.dungeon.storage
{
   import game.data.storage.DescriptionBase;
   
   public class DungeonFloorDescription extends DescriptionBase
   {
       
      
      private var _type:DungeonFloorType;
      
      private var _saveInteractionType:SaveInteractionType;
      
      private var _isStatic:Boolean;
      
      private const LIB_BATTLE:String = "battle";
      
      private const LIB_SUB_NEUTRAL:String = "neutral";
      
      private const LIB_SUB_HERO:String = "hero";
      
      private const LIB_SUB_PRIME:String = "prime";
      
      private const LIB_SUB_NONPRIME:String = "nonprime";
      
      public function DungeonFloorDescription(param1:Object)
      {
         super();
         _id = param1.id;
         _isStatic = int(param1.isStatic) == 1;
         determineFloorType(param1);
         _saveInteractionType = SaveInteractionType.getByIdent(param1.savePointInteraction);
      }
      
      public function get type() : DungeonFloorType
      {
         return _type;
      }
      
      public function get saveInteractionType() : SaveInteractionType
      {
         return _saveInteractionType;
      }
      
      public function get isStatic() : Boolean
      {
         return _isStatic;
      }
      
      private function determineFloorType(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:Array = param1.battleRollData;
         if(param1.type == "battle")
         {
            _loc3_ = _loc4_[0];
            _loc5_ = null;
            var _loc7_:int = 0;
            var _loc6_:* = _loc3_;
            for(_loc5_ in _loc3_)
            {
            }
            if(_loc5_ == "hero")
            {
               _type = DungeonFloorType.BATTLE_HERO;
            }
            else if(_loc5_ == "neutral" || _loc5_ == "nonprime" || _loc5_ == "prime")
            {
               if(_loc4_.length > 1)
               {
                  _type = DungeonFloorType.BATTLE_TITAN_CHOICE;
               }
               else
               {
                  _type = DungeonFloorType.BATTLE_TITAN_SINGLE;
               }
            }
         }
      }
   }
}
