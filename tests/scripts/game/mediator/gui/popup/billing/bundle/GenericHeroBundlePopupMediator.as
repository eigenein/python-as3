package game.mediator.gui.popup.billing.bundle
{
   import game.data.storage.DataStorage;
   import game.data.storage.bundle.BundleHeroReward;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.hero.skill.SkillTooltipMessageFactory;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroEntrySourceData;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.bundle.Bundle4Popup;
   
   public class GenericHeroBundlePopupMediator extends BundlePopupMediator
   {
       
      
      private var _hero:HeroDescription;
      
      private var _skills:Vector.<BundleSkillValueObject>;
      
      public function GenericHeroBundlePopupMediator(param1:Player)
      {
         var _loc5_:int = 0;
         var _loc9_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:* = null;
         var _loc4_:* = null;
         super(param1);
         _loc2_ = _reward.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            if(_reward[_loc5_].item is HeroDescription)
            {
               _hero = DataStorage.hero.getHeroById(_reward[_loc5_].id);
            }
            _loc5_++;
         }
         if(!_hero && bundle.bundleHeroReward && bundle.bundleHeroReward.length)
         {
            _loc9_ = bundle.bundleHeroReward[0];
            _hero = DataStorage.hero.getHeroById(_loc9_.heroId);
            if(param1.heroes.getById(_hero.id))
            {
               _reward.push(_loc9_.heroFragments);
            }
            else
            {
               _reward.push(new InventoryItem(DataStorage.hero.getHeroById(_loc9_.heroId),1));
            }
         }
         var _loc6_:Vector.<SkillDescription> = DataStorage.skill.getByHero(_hero.id).concat();
         _loc6_.sort(SkillDescription.sort_byTier);
         _loc6_.shift();
         _skills = new Vector.<BundleSkillValueObject>();
         var _loc7_:PlayerHeroEntry = new PlayerHeroEntry(_hero,PlayerHeroEntrySourceData.createEmpty(_hero));
         _loc2_ = _loc6_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc8_ = new SkillTooltipMessageFactory(_loc7_,_loc6_[_loc3_]);
            _loc4_ = new BundleSkillValueObject(_loc6_[_loc3_],_loc8_);
            _skills.push(_loc4_);
            _loc3_++;
         }
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
      
      public function get skills() : Vector.<BundleSkillValueObject>
      {
         return _skills;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new Bundle4Popup(this);
         return _popup;
      }
      
      private function _createPlayerData() : Object
      {
         var _loc3_:int = 0;
         var _loc2_:HeroDescription = _hero;
         var _loc4_:Object = {};
         _loc4_.skills = [];
         var _loc1_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(_loc2_.id);
         var _loc5_:int = _loc1_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            if(_loc2_.startingColor.skillTierAvailable >= _loc1_[_loc3_].tier)
            {
               _loc4_.skills[_loc1_[_loc3_].id] = DataStorage.enum.getbyId_SkillTier(_loc1_[_loc3_].tier).skillMinLevel + 1;
            }
            _loc3_++;
         }
         _loc4_.star = _loc2_.startingStar.star.id;
         _loc4_.color = _loc2_.startingColor.color.id;
         return _loc4_;
      }
   }
}
