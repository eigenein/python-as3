package game.data.storage.chest
{
   import game.data.storage.DataStorage;
   import game.data.storage.gear.GearItemDescription;
   
   public class ChestRewardPresentation
   {
      
      private static const F_HERO_REWARD_PRESENTATION:String = "hero";
      
      private static const F_HERO_MISC_REWARD_PRESENTATION:String = "hero_misc";
      
      private static const F_UNIQUE_REWARD_PRESENTATION:String = "unique_hero";
       
      
      private var _hero:Vector.<ChestRewardPresentationValueObject>;
      
      private var _misc_hero:Vector.<ChestRewardPresentationValueObject>;
      
      private var _uniqueHero:Vector.<ChestRewardPresentationValueObject>;
      
      public function ChestRewardPresentation(param1:Object)
      {
         _hero = new Vector.<ChestRewardPresentationValueObject>();
         _misc_hero = new Vector.<ChestRewardPresentationValueObject>();
         _uniqueHero = new Vector.<ChestRewardPresentationValueObject>();
         super();
         _hero = new Vector.<ChestRewardPresentationValueObject>();
         parseHero(_hero,param1["hero"]);
         _uniqueHero = new Vector.<ChestRewardPresentationValueObject>();
         parseHero(_uniqueHero,param1["unique_hero"],true);
         _misc_hero = new Vector.<ChestRewardPresentationValueObject>();
         parseHero(_misc_hero,param1["hero_misc"]);
      }
      
      public function get hero() : Vector.<ChestRewardPresentationValueObject>
      {
         return _hero;
      }
      
      public function get misc_hero() : Vector.<ChestRewardPresentationValueObject>
      {
         return _misc_hero;
      }
      
      public function get uniqueHero() : Vector.<ChestRewardPresentationValueObject>
      {
         return _uniqueHero;
      }
      
      private function parseHero(param1:Vector.<ChestRewardPresentationValueObject>, param2:Object, param3:Boolean = false) : void
      {
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = param2;
         for(var _loc5_ in param2)
         {
            _loc4_ = new ChestRewardPresentationValueObject(DataStorage.hero.getHeroById(_loc5_),param2[_loc5_].priority,param2[_loc5_].is_new);
            _loc4_.is_unique = param3;
            param1.push(_loc4_);
         }
         param1.sort(_sort);
      }
      
      private function parseGear(param1:Vector.<ChestRewardPresentationValueObject>, param2:Object) : void
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param2;
         for(var _loc4_ in param2)
         {
            _loc3_ = new ChestRewardPresentationValueObject(DataStorage.gear.getById(_loc4_) as GearItemDescription,param2[_loc4_].priority,param2[_loc4_].is_new);
            param1.push(_loc3_);
         }
         param1.sort(_sort);
      }
      
      private function _sort(param1:ChestRewardPresentationValueObject, param2:ChestRewardPresentationValueObject) : int
      {
         return param2.priority - param1.priority;
      }
   }
}
