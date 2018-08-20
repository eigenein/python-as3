package game.data.storage.bundle
{
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.skin.SkinDescription;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.HeroEntrySourceData;
   import game.model.user.inventory.InventoryFragmentItem;
   
   public class BundleHeroReward
   {
      
      public static const TYPE_SUMMON:String = "summon";
      
      public static const TYPE_EVOLVE:String = "evolve";
      
      public static const TYPE_SKIN:String = "skin";
       
      
      private var _splittedIntoFragments:Boolean = false;
      
      private var _id:int;
      
      private var _skin:SkinDescription;
      
      private var _hero:HeroDescription;
      
      private var _reward:Object;
      
      private var _reward_skills:Object;
      
      private var _heroEntry:HeroEntry;
      
      private var _heroFragments:InventoryFragmentItem;
      
      private var _type:String;
      
      public function BundleHeroReward(param1:Object)
      {
         super();
         _id = param1.id;
         _reward = param1.reward;
         _type = param1.type;
         if(_type == "skin")
         {
            _skin = DataStorage.skin.getById(_reward.id) as SkinDescription;
            _hero = DataStorage.hero.getHeroById(_skin.heroId);
         }
         else
         {
            _hero = DataStorage.hero.getHeroById(_reward.id);
         }
         _heroFragments = new InventoryFragmentItem(_hero,_reward.fragmentCount);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get skin() : SkinDescription
      {
         return _skin;
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
      
      public function get reward() : Object
      {
         return _reward;
      }
      
      public function get reward_level() : int
      {
         return _reward.level;
      }
      
      public function get reward_star() : int
      {
         return _reward.star;
      }
      
      public function get reward_color() : int
      {
         return _reward.color;
      }
      
      public function get reward_skills() : Object
      {
         var _loc3_:int = 0;
         if(!_reward.skills)
         {
            return null;
         }
         var _loc2_:Object = {};
         var _loc1_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(heroId);
         var _loc4_:int = _loc1_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(_reward.skills[_loc1_[_loc3_].tier])
            {
               _loc2_[_loc1_[_loc3_].id] = _reward.skills[_loc1_[_loc3_].tier];
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get heroEntry() : HeroEntry
      {
         var _loc1_:* = null;
         if(!_heroEntry)
         {
            _loc1_ = DataStorage.hero.getHeroById(_reward.id);
            if(!_reward.star)
            {
               _reward.star = _loc1_.startingStar.star.id;
            }
            if(!_reward.level)
            {
               _reward.level = 1;
            }
            if(!_reward.color)
            {
               _reward.color = _loc1_.startingColor.color.id;
            }
            _heroEntry = new HeroEntry(_loc1_,new HeroEntrySourceData(_reward));
         }
         return _heroEntry;
      }
      
      public function get heroFragments() : InventoryFragmentItem
      {
         return _heroFragments;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get heroId() : int
      {
         return _reward.id;
      }
      
      public function get splittedIntoFragments() : Boolean
      {
         return _splittedIntoFragments;
      }
      
      public function setSplittedIntoFragments() : void
      {
         _splittedIntoFragments = true;
      }
   }
}
