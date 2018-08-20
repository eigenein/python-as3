package game.mechanics.clan_war.storage
{
   import flash.utils.Dictionary;
   import game.data.storage.DescriptionBase;
   
   public class ClanWarStorage
   {
       
      
      private var fortifications:Dictionary;
      
      private var slots:Dictionary;
      
      private var leagues:Vector.<ClanWarLeagueDescription>;
      
      public function ClanWarStorage()
      {
         fortifications = new Dictionary();
         slots = new Dictionary();
         leagues = new Vector.<ClanWarLeagueDescription>();
         super();
      }
      
      public function getLeagueById(param1:int) : ClanWarLeagueDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getLeaguesList() : Vector.<ClanWarLeagueDescription>
      {
         return leagues;
      }
      
      public function getFortificationList() : Vector.<ClanWarFortificationDescription>
      {
         var _loc2_:Vector.<ClanWarFortificationDescription> = new Vector.<ClanWarFortificationDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = fortifications;
         for each(var _loc1_ in fortifications)
         {
            _loc2_.push(_loc1_);
         }
         _loc2_.sort(_sortById);
         return _loc2_;
      }
      
      public function init(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc9_:* = 0;
         var _loc8_:* = param1.fortification;
         for each(_loc2_ in param1.fortification)
         {
            _loc4_ = new ClanWarFortificationDescription(_loc2_);
            fortifications[_loc4_.id] = _loc4_;
         }
         var _loc5_:Dictionary = new Dictionary();
         var _loc12_:int = 0;
         var _loc11_:* = param1.fortificationSlot;
         for each(_loc2_ in param1.fortificationSlot)
         {
            _loc3_ = new ClanWarSlotDescription(_loc2_);
            slots[_loc3_.id] = _loc3_;
            _loc4_ = fortifications[_loc3_.fortificationId];
            _loc4_.addSlot(_loc3_);
            if(!_loc5_[_loc4_])
            {
               _loc5_[_loc4_] = 0;
            }
            _loc9_ = _loc5_;
            _loc8_ = _loc4_;
            var _loc10_:* = Number(_loc9_[_loc8_]) + 1;
            _loc9_[_loc8_] = _loc10_;
            _loc3_.internal_setSlotIndex(Number(_loc9_[_loc8_]));
            _loc3_.internal_setFortificationDesc(_loc4_);
         }
         var _loc14_:int = 0;
         var _loc13_:* = param1.league;
         for each(_loc2_ in param1.league)
         {
            _loc7_ = new ClanWarLeagueDescription(_loc2_);
            leagues.push(_loc7_);
         }
         _loc6_ = 1;
         while(_loc6_ < leagues.length)
         {
            leagues[_loc6_].bestCount = leagues[_loc6_ - 1].promoCount;
            _loc6_++;
         }
      }
      
      public function applyLocale() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = fortifications;
         for each(var _loc1_ in fortifications)
         {
            _loc1_.applyLocale();
         }
      }
      
      public function getSlotById(param1:int) : ClanWarSlotDescription
      {
         return slots[param1];
      }
      
      public function getFortificationById(param1:int) : ClanWarFortificationDescription
      {
         return fortifications[param1];
      }
      
      private function _sortById(param1:DescriptionBase, param2:DescriptionBase) : int
      {
         return param1.id - param2.id;
      }
   }
}
