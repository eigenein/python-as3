package game.mediator.gui.popup.billing.bundle
{
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.level.VIPLevel;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.hero.skill.SkillTooltipMessageFactory;
   import game.model.user.Player;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroEntrySourceData;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.bundle.Bundle3Popup;
   
   public class Bundle3PopupMediator extends BundlePopupMediator
   {
       
      
      private var _heroEntry:HeroEntry;
      
      private var _hero:HeroDescription;
      
      private var _skills:Vector.<BundleSkillValueObject>;
      
      private var _vipLevel:VIPLevel;
      
      public function Bundle3PopupMediator(param1:Player)
      {
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc5_:* = null;
         _loc4_ = 0;
         super(param1);
         _hero = DataStorage.hero.getHeroById(9);
         var _loc6_:Vector.<SkillDescription> = DataStorage.skill.getByHero(_hero.id).concat();
         _loc6_.sort(SkillDescription.sort_byTier);
         _loc6_.shift();
         _skills = new Vector.<BundleSkillValueObject>();
         var _loc7_:PlayerHeroEntry = new PlayerHeroEntry(_hero,PlayerHeroEntrySourceData.createEmpty(_hero));
         var _loc2_:int = _loc6_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc8_ = new SkillTooltipMessageFactory(_loc7_,_loc6_[_loc4_]);
            _loc5_ = new BundleSkillValueObject(_loc6_[_loc4_],_loc8_);
            _skills.push(_loc5_);
            _loc4_++;
         }
         _heroEntry = bundle.bundleHeroReward[0].heroEntry;
         _vipLevel = DataStorage.level.getVipLevelByVipPoints(param1.vipLevel.exp + bundle.reward.vipPoints);
         var _loc3_:int = _reward.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_reward[_loc4_].item is HeroDescription)
            {
               _reward.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
      }
      
      override protected function dispose() : void
      {
         super.dispose();
      }
      
      public function get isMissionLocked() : Boolean
      {
         return bundle.requirement_missionId;
      }
      
      public function get heroEntry() : HeroEntry
      {
         return _heroEntry;
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
      
      public function get skills() : Vector.<BundleSkillValueObject>
      {
         return _skills;
      }
      
      public function get vipLevel() : VIPLevel
      {
         return _vipLevel;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new Bundle3Popup(this);
         return _popup;
      }
   }
}
