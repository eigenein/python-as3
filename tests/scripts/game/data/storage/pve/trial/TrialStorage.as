package game.data.storage.pve.trial
{
   import flash.utils.Dictionary;
   import game.data.storage.DescriptionStorage;
   
   public class TrialStorage extends DescriptionStorage
   {
      
      public static const GROUP_TYPE_CHRONO_PORTAL:int = 1;
      
      public static const GROUP_TYPE_TRIAL:int = 2;
       
      
      private var types:Dictionary;
      
      public function TrialStorage()
      {
         super();
         types = new Dictionary();
      }
      
      public function getByGroup(param1:int) : Vector.<TrialDescription>
      {
         var _loc3_:Vector.<TrialDescription> = new Vector.<TrialDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_.type.questType == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getType(param1:String) : TrialTypeDescription
      {
         return types[param1];
      }
      
      override public function init(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = param1.type;
         for(var _loc3_ in param1.type)
         {
            _loc2_ = new TrialTypeDescription(param1.type[_loc3_]);
            types[_loc2_.type] = _loc2_;
         }
         super.init(param1.battle);
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:TrialDescription = new TrialDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
   }
}
