package game.mediator.gui.popup.hero.skin
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.inventory.ItemInfoPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import starling.textures.Texture;
   
   public class SkinInfoPopUpMediator extends PopupMediator
   {
       
      
      private var skin:SkinDescription;
      
      private var _userHero:PlayerHeroEntry;
      
      private var _hero:HeroDescription;
      
      private var _skinID:uint;
      
      public function SkinInfoPopUpMediator(param1:Player, param2:uint)
      {
         super(param1);
         this.skinID = param2;
         skin = DataStorage.skin.getSkinById(param2);
         hero = DataStorage.hero.getHeroById(skin.heroId);
         userHero = param1.heroes.getById(hero.id);
      }
      
      public function get userHero() : PlayerHeroEntry
      {
         return _userHero;
      }
      
      public function set userHero(param1:PlayerHeroEntry) : void
      {
         _userHero = param1;
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
      
      public function set hero(param1:HeroDescription) : void
      {
         _hero = param1;
      }
      
      public function get skinID() : uint
      {
         return _skinID;
      }
      
      public function set skinID(param1:uint) : void
      {
         _skinID = param1;
      }
      
      public function get skinName() : String
      {
         if(skin)
         {
            return skin.name;
         }
         return null;
      }
      
      public function get skinMaxLevel() : uint
      {
         return skin.levels.length;
      }
      
      public function get skinIcon() : Texture
      {
         return AssetStorage.inventory.getSkinTexture(hero,skin);
      }
      
      public function get canBeUpgraded() : Boolean
      {
         return skin.levels.length > 1 && skin.levels[1].cost != null;
      }
      
      public function get upgradeCostItemIcon() : Texture
      {
         return AssetStorage.inventory.getItemGUIIconTexture(skin.levels[1].cost.outputDisplayFirst.item);
      }
      
      public function get upgradeCostItemName() : String
      {
         return skin.levels[1].cost.outputDisplayFirst.name;
      }
      
      public function get specialOfferExplicit() : Boolean
      {
         return skin.eventId > 0;
      }
      
      public function get skinLevel() : uint
      {
         var _loc2_:* = 0;
         if(userHero)
         {
            _loc2_ = uint(userHero.skinData.getSkinLevelByID(skinID));
            if(_loc2_ > 0)
            {
               return _loc2_;
            }
         }
         var _loc1_:InventoryItem = player.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.SKIN).getItemById(skin.id);
         if(_loc1_)
         {
            return Math.min(_loc1_.amount,skinMaxLevel);
         }
         return 1;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SkinInfoPopUp(this);
         return _popup;
      }
      
      public function getStatBonusByLevel(param1:uint) : BattleStatValueObject
      {
         if(param1 > 0 && param1 <= skin.levels.length)
         {
            return skin.levels[param1 - 1].statBonus;
         }
         return null;
      }
      
      public function showRecieveInfo() : void
      {
         var _loc1_:ItemInfoPopupMediator = new ItemInfoPopupMediator(player,hero);
         _loc1_.open(Stash.click("skin_info",_popup.stashParams));
      }
   }
}
