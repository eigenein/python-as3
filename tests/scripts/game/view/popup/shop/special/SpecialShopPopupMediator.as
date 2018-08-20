package game.view.popup.shop.special
{
   import battle.BattleStats;
   import feathers.data.ListCollection;
   import game.command.rpc.shop.CommandSpecialShopBuy;
   import game.data.storage.DataStorage;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.hero.HeroColorData;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.bundle.BundleSkillValueObject;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.HeroInventoryProxy;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.mediator.gui.popup.hero.skill.SkillTooltipMessageFactory;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.popup.hero.slot.HeroInventorySlotValueObject;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroEntrySourceData;
   import game.model.user.hero.PlayerHeroSkillData;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.shop.SpecialShopHeroListValueObject;
   import game.model.user.shop.SpecialShopMerchant;
   import game.model.user.shop.SpecialShopSlotValueObject;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class SpecialShopPopupMediator extends PopupMediator
   {
       
      
      private var _inventory:HeroInventoryProxy;
      
      private var _miniHeroListDataProvider:ListCollection;
      
      private var _rankIncrease:Boolean;
      
      private var _hero:SpecialShopHeroListValueObject;
      
      private var _merchant:SpecialShopMerchant;
      
      private var _after:HeroEntryValueObject;
      
      private var _skill:BundleSkillValueObject;
      
      private var _battleStatSummary:Vector.<BattleStatValueObject>;
      
      private var _powerIncrease:int;
      
      private var _signal_heroChanged:Signal;
      
      public function SpecialShopPopupMediator(param1:SpecialShopMerchant)
      {
         _signal_heroChanged = new Signal();
         super(GameModel.instance.player);
         _merchant = param1;
         _merchant.signal_expire.add(handler_merchantExpire);
         createMiniList();
         hero = _miniHeroListDataProvider.getItemAt(0) as SpecialShopHeroListValueObject;
      }
      
      override protected function dispose() : void
      {
         _merchant.signal_expire.remove(handler_merchantExpire);
         _inventory.dispose();
         hero = null;
         super.dispose();
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         return _loc1_;
      }
      
      public function get miniHeroListDataProvider() : ListCollection
      {
         return _miniHeroListDataProvider;
      }
      
      public function get rankIncrease() : Boolean
      {
         return _rankIncrease;
      }
      
      public function get totalCost() : InventoryItem
      {
         return hero.shopHero.getTotalCost().outputDisplay[0];
      }
      
      public function get discountAmount() : int
      {
         return hero.shopHero.discountAmount;
      }
      
      public function get hero() : SpecialShopHeroListValueObject
      {
         return _hero;
      }
      
      public function set hero(param1:SpecialShopHeroListValueObject) : void
      {
         if(_hero == param1)
         {
            return;
         }
         _hero = param1;
         if(_hero)
         {
            _inventory = new HeroInventoryProxy(player,hero.playerHero);
            updateHeroParams();
         }
         signal_heroChanged.dispatch();
      }
      
      public function get inventoryList() : Vector.<HeroInventorySlotValueObject>
      {
         return _inventory.inventory;
      }
      
      public function get merchant() : SpecialShopMerchant
      {
         return _merchant;
      }
      
      public function get after() : HeroEntryValueObject
      {
         return _after;
      }
      
      public function get skill() : BundleSkillValueObject
      {
         return _skill;
      }
      
      public function get battleStatSummary() : Vector.<BattleStatValueObject>
      {
         return _battleStatSummary;
      }
      
      public function get powerIncrease() : int
      {
         return _powerIncrease;
      }
      
      public function get signal_heroChanged() : Signal
      {
         return _signal_heroChanged;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SpecialShopPopup(this);
         _popup.stashParams.windowName = "special_shop:" + _merchant.id;
         return _popup;
      }
      
      public function action_miniListSelectionUpdate(param1:SpecialShopHeroListValueObject) : void
      {
         hero = param1;
      }
      
      public function action_promote() : void
      {
         var _loc1_:CommandSpecialShopBuy = GameModel.instance.actionManager.shop.specialShopBuy(merchant,hero.shopHero);
         _loc1_.signal_complete.addOnce(handler_onBuyComplete);
      }
      
      private function createMiniList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Vector.<SpecialShopHeroListValueObject> = new Vector.<SpecialShopHeroListValueObject>();
         _loc3_ = 0;
         while(_loc3_ < _merchant.heroes.length)
         {
            _loc2_ = new SpecialShopHeroListValueObject(_merchant.heroes[_loc3_]);
            _loc2_.playerHero = GameModel.instance.player.heroes.getById(_loc2_.shopHero.heroId);
            _loc2_.playerHeroListVO = new PlayerHeroListValueObject(_loc2_.playerHero.hero,player);
            _loc1_.push(_loc2_);
            _loc3_++;
         }
         _loc1_.sort(SpecialShopHeroListValueObject.sort);
         _miniHeroListDataProvider = new ListCollection(_loc1_);
      }
      
      private function updateHeroParams() : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         var _loc2_:Array = [-1,-1,-1,-1,-1,-1];
         var _loc3_:int = inventoryList.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = inventoryList[_loc6_];
            if(_loc4_.slotState == 2)
            {
               _loc2_[_loc6_] = 0;
            }
            _loc6_++;
         }
         var _loc9_:BattleStats = new BattleStats();
         var _loc13_:int = 0;
         var _loc12_:* = hero.shopHero.slots;
         for each(var _loc7_ in hero.shopHero.slots)
         {
            if(_loc7_.canBuy())
            {
               _loc2_[_loc7_.heroSlotId] = 0;
               _loc9_.add((_loc7_.item.item as GearItemDescription).battleStatData);
            }
         }
         _battleStatSummary = BattleStatValueObjectProvider.fromBattleStats(_loc9_);
         var _loc1_:* = Boolean(hero.playerHero.color.next != null && hero.playerHero.color.next.color.id > hero.playerHero.color.color.id);
         _loc8_ = 0;
         while(_loc1_ && _loc8_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc8_] >= 0;
            _loc8_++;
         }
         if(_loc1_)
         {
            _after = new HeroEntryValueObject(hero.playerHero.hero,new PlayerHeroEntry(hero.playerHero.hero,new PlayerHeroEntrySourceData({
               "xp":hero.playerHero.level.exp,
               "star":hero.playerHero.star.star.id,
               "color":hero.playerHero.color.next.color.id,
               "slots":[-1,-1,-1,-1,-1,-1],
               "skills":createRawSkillData(hero.playerHero.color.next,hero.playerHero.skillData)
            })));
         }
         else
         {
            _after = new HeroEntryValueObject(hero.playerHero.hero,new PlayerHeroEntry(hero.playerHero.hero,new PlayerHeroEntrySourceData({
               "xp":hero.playerHero.level.exp,
               "star":hero.playerHero.star.star.id,
               "color":hero.playerHero.color.color.id,
               "slots":_loc2_,
               "skills":createRawSkillData(hero.playerHero.color,hero.playerHero.skillData)
            })));
         }
         _rankIncrease = _loc1_;
         var _loc5_:int = after.heroEntry.color.color.skillTierUnlock;
         if(_loc1_ && _loc5_)
         {
            _loc10_ = new SkillTooltipMessageFactory(after.heroEntry as PlayerHeroEntry,DataStorage.skill.getByHeroAndTier(after.id,_loc5_));
            _loc11_ = 1;
            _skill = new BundleSkillValueObject(DataStorage.skill.getByHeroAndTier(after.id,_loc5_),_loc10_,_loc11_);
         }
         else
         {
            _skill = null;
         }
         _powerIncrease = after.heroEntry.getPower() - hero.playerHero.getPower();
      }
      
      private function createRawSkillData(param1:HeroColorData, param2:PlayerHeroSkillData) : Object
      {
         var _loc5_:int = 0;
         var _loc4_:Object = [];
         var _loc3_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(hero.playerHero.id);
         var _loc6_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            if(param1.skillTierAvailable >= _loc3_[_loc5_].tier)
            {
               if(param2.getLevelByTier(_loc3_[_loc5_].tier))
               {
                  _loc4_[_loc3_[_loc5_].id] = param2.getLevelByTier(_loc3_[_loc5_].tier).level;
               }
               else
               {
                  _loc4_[_loc3_[_loc5_].id] = DataStorage.enum.getbyId_SkillTier(_loc3_[_loc5_].tier).skillMinLevel + 1;
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function handler_onBuyComplete(param1:CommandSpecialShopBuy) : void
      {
         close();
      }
      
      private function handler_merchantExpire(param1:SpecialShopMerchant) : void
      {
         close();
      }
   }
}
