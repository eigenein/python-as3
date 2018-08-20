package game.data.storage.pve.mission
{
   import flash.utils.Dictionary;
   import game.data.storage.DescriptionBase;
   import game.data.storage.DescriptionStorage;
   
   public class MissionStorage extends DescriptionStorage
   {
       
      
      private const normalMode:Dictionary = new Dictionary();
      
      private const dropList_gear:Dictionary = new Dictionary();
      
      private const dropList_fragmentGear:Dictionary = new Dictionary();
      
      private const dropList_scroll:Dictionary = new Dictionary();
      
      private const dropList_fragmentScroll:Dictionary = new Dictionary();
      
      public function MissionStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:* = null;
         _loc2_ = new MissionDescription(param1,param1.normalMode);
         normalMode[_loc2_.id] = _loc2_;
      }
      
      public function getMissionById(param1:int) : MissionDescription
      {
         return normalMode[param1];
      }
      
      override public function getById(param1:uint) : DescriptionBase
      {
         throw new Error("MissionStorage:getById - use get<mode>ById");
      }
      
      override public function applyLocale() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = normalMode;
         for each(var _loc1_ in normalMode)
         {
            _loc1_.applyLocale();
         }
      }
      
      public function getNormalModeList() : Vector.<MissionDescription>
      {
         var _loc1_:Vector.<MissionDescription> = new Vector.<MissionDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = normalMode;
         for each(var _loc2_ in normalMode)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getByWorld(param1:int) : Vector.<MissionDescription>
      {
         var _loc2_:Vector.<MissionDescription> = new Vector.<MissionDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = normalMode;
         for each(var _loc3_ in normalMode)
         {
            if(_loc3_.world == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getNextMission(param1:MissionDescription) : MissionDescription
      {
         if(!param1)
         {
            return null;
         }
         var _loc3_:int = getLastWorldIndex();
         var _loc5_:MissionDescription = null;
         var _loc4_:int = param1.index;
         var _loc2_:int = param1.world;
         while(!_loc5_ && _loc2_ <= _loc3_)
         {
            _loc4_ = _loc4_ + 1;
            if(_loc4_ > getWorldMaxIndex(_loc2_))
            {
               _loc2_++;
               _loc4_ = 1;
            }
            _loc5_ = getByWorldIndex(_loc2_,_loc4_);
         }
         return _loc5_;
      }
      
      public function getPreviousMission(param1:MissionDescription) : MissionDescription
      {
         var _loc3_:int = param1.index;
         var _loc2_:int = param1.world;
         var _loc4_:MissionDescription = null;
         if(param1.prevMissionIndex)
         {
            _loc4_ = getByWorldIndex(_loc2_,param1.prevMissionIndex);
         }
         else
         {
            while(!_loc4_ && _loc2_ > 0)
            {
               _loc3_ = _loc3_ - 1;
               if(_loc3_ == 0)
               {
                  _loc2_--;
                  _loc3_ = getWorldMaxIndex(_loc2_);
               }
               _loc4_ = getByWorldIndex(_loc2_,_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function getByWorldIndex(param1:int, param2:int) : MissionDescription
      {
         var _loc5_:int = 0;
         var _loc4_:* = normalMode;
         for each(var _loc3_ in normalMode)
         {
            if(!_loc3_.isParallel)
            {
               if(_loc3_.world == param1 && _loc3_.index == param2)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      private function getWorldMaxIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = normalMode;
         for each(var _loc2_ in normalMode)
         {
            if(_loc2_.world == param1)
            {
               _loc3_ = Math.max(_loc3_,_loc2_.index);
            }
         }
         return _loc3_;
      }
      
      private function getLastWorldIndex() : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = normalMode;
         for each(var _loc1_ in normalMode)
         {
            _loc2_ = Math.max(_loc2_,_loc1_.world);
         }
         return _loc2_;
      }
   }
}
