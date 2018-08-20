package game.mediator.gui.popup.billing.bundle
{
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.skill.SkillTooltipMessageFactory;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroEntrySourceData;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.bundle.HeroSpecialOfferPopup;
   import org.osflash.signals.Signal;
   
   public class HeroSpecialOfferPopupMediator extends PopupMediator
   {
       
      
      private var _desc:HeroBundlePopupDescription;
      
      private var _reward:Vector.<InventoryItem>;
      
      private var _hero:HeroDescription;
      
      private var _skills:Vector.<BundleSkillValueObject>;
      
      public function HeroSpecialOfferPopupMediator(param1:Player, param2:HeroBundlePopupDescription)
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:* = null;
         var _loc5_:* = null;
         super(param1);
         _desc = param2;
         _reward = param2.reward.outputDisplay;
         _reward.sort(_sortReward);
         var _loc3_:int = _reward.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            if(_reward[_loc6_].item is HeroDescription)
            {
               _hero = DataStorage.hero.getHeroById(_reward[_loc6_].id);
            }
            _loc6_++;
         }
         var _loc7_:Vector.<SkillDescription> = DataStorage.skill.getByHero(_hero.id).concat();
         _loc7_.sort(SkillDescription.sort_byTier);
         _loc7_.shift();
         _skills = new Vector.<BundleSkillValueObject>();
         var _loc8_:PlayerHeroEntry = new PlayerHeroEntry(_hero,PlayerHeroEntrySourceData.createEmpty(_hero));
         _loc3_ = _loc7_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc9_ = new SkillTooltipMessageFactory(_loc8_,_loc7_[_loc4_]);
            _loc5_ = new BundleSkillValueObject(_loc7_[_loc4_],_loc9_);
            _skills.push(_loc5_);
            _loc4_++;
         }
         _desc.signal_removed.add(handler_remove);
      }
      
      override protected function dispose() : void
      {
         _desc.signal_click.removeAll();
         _desc.signal_removed.remove(handler_remove);
         super.dispose();
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
      
      public function get skills() : Vector.<BundleSkillValueObject>
      {
         return _skills;
      }
      
      public function get description() : String
      {
         return _desc.description;
      }
      
      public function get title() : String
      {
         return _desc.title;
      }
      
      public function get signal_updateTimeLeft() : Signal
      {
         return _desc.signal_updateTimeLeft;
      }
      
      public function get isOver() : Boolean
      {
         return _desc.timeLeftMethod() == "00:00:00";
      }
      
      public function get timeLeftString() : String
      {
         return _desc.timeLeftMethod();
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return _reward;
      }
      
      public function get costString() : String
      {
         return _desc.price;
      }
      
      public function get oldPrice() : String
      {
         return _desc.oldPrice;
      }
      
      public function get buttonLabel() : String
      {
         return _desc.buttonLabel;
      }
      
      public function get discountValue() : int
      {
         return _desc.discountValue;
      }
      
      public function get stashWindowName() : String
      {
         return _desc.stashWindowName;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroSpecialOfferPopup(this);
         return _popup;
      }
      
      public function action_button() : void
      {
         _desc.signal_click.dispatch();
         close();
      }
      
      protected function _sortReward(param1:InventoryItem, param2:InventoryItem) : int
      {
         var _loc3_:int = getRewardSortValue(param1);
         var _loc4_:int = getRewardSortValue(param2);
         return _loc4_ - _loc3_;
      }
      
      protected function getRewardSortValue(param1:InventoryItem) : int
      {
         var _loc2_:int = 0;
         if(param1.item == DataStorage.pseudo.STARMONEY)
         {
            _loc2_ = _loc2_ + 10000;
         }
         if(param1.item is HeroDescription)
         {
            _loc2_ = _loc2_ + 1000;
         }
         if(param1.item is PseudoResourceDescription)
         {
            _loc2_ = _loc2_ + 100;
         }
         return _loc2_;
      }
      
      private function handler_remove() : void
      {
         close();
      }
   }
}
