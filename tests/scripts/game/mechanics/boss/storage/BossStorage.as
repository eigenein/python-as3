package game.mechanics.boss.storage
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   
   public class BossStorage
   {
       
      
      public const timetableDurationDays:int = 7;
      
      private var bossTypeById:Dictionary;
      
      private var bossList:Vector.<BossTypeDescription>;
      
      private var chests:Vector.<BossChestDescription>;
      
      public const timetable:Vector.<BossTypeDescription> = new Vector.<BossTypeDescription>(7,true);
      
      public function BossStorage()
      {
         bossTypeById = new Dictionary();
         bossList = new Vector.<BossTypeDescription>();
         chests = new Vector.<BossChestDescription>();
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc5_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = param1.list;
         for each(var _loc3_ in param1.list)
         {
            _loc5_ = new BossTypeDescription(_loc3_);
            bossList.push(_loc5_);
            if(_loc3_.enabled != false)
            {
               bossTypeById[_loc5_.id] = _loc5_;
               var _loc7_:int = 0;
               var _loc6_:* = _loc5_.day;
               for each(var _loc4_ in _loc5_.day)
               {
                  timetable[_loc4_ - 1] = _loc5_;
               }
               continue;
            }
         }
         var _loc11_:int = 0;
         var _loc10_:* = param1.chest;
         for each(var _loc2_ in param1.chest)
         {
            chests.push(new BossChestDescription(_loc2_));
         }
      }
      
      public function applyLocale() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = bossTypeById;
         for each(var _loc1_ in bossTypeById)
         {
            _loc1_.applyLocale();
         }
      }
      
      public function getByType(param1:int) : BossTypeDescription
      {
         return bossTypeById[param1];
      }
      
      public function getAllTypesList() : Vector.<BossTypeDescription>
      {
         var _loc1_:Vector.<BossTypeDescription> = new Vector.<BossTypeDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = bossTypeById;
         for each(var _loc2_ in bossTypeById)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getBossByUnitId(param1:int) : BossTypeDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getChestByNum(param1:int) : BossChestDescription
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = DataStorage.rule.bossRule.chestRepeatFromId;
         if(param1 > chests.length)
         {
            _loc4_ = param1 - chests.length - 1;
            _loc5_ = chests.length - _loc2_ + 1;
            _loc3_ = _loc2_ + _loc4_ % _loc5_;
            return chests[_loc3_ - 1];
         }
         if(param1 >= 1)
         {
            return chests[param1 - 1];
         }
         return null;
      }
   }
}
