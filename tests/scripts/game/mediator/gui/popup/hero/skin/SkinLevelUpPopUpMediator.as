package game.mediator.gui.popup.hero.skin
{
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.HeroRewardPopupHandler;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.inventory.ItemInfoPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class SkinLevelUpPopUpMediator extends PopupMediator
   {
       
      
      private var skin:SkinDescription;
      
      private var _userHero:PlayerHeroEntry;
      
      private var _hero:HeroDescription;
      
      private var _skinID:uint;
      
      public function SkinLevelUpPopUpMediator(param1:Player, param2:uint)
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
      
      public function get skinLevel() : uint
      {
         if(userHero)
         {
            return userHero.skinData.getSkinLevelByID(skinID);
         }
         var _loc1_:InventoryItem = player.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.SKIN).getItemById(skin.id);
         if(_loc1_)
         {
            return Math.min(_loc1_.amount,skinMaxLevel);
         }
         return 1;
      }
      
      public function get skinMaxLevel() : uint
      {
         return skin.levels.length;
      }
      
      override public function close() : void
      {
         super.close();
         HeroRewardPopupHandler.instance.release();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SkinLevelUpPopUp(this);
         return _popup;
      }
      
      public function getSkinDescription() : String
      {
         var _loc1_:BattleStatValueObject = getStatBonusByLevel(skinLevel);
         if(_loc1_)
         {
            return ColorUtils.hexToRGBFormat(16573879) + _loc1_.name + ": " + ColorUtils.hexToRGBFormat(16645626) + "+" + _loc1_.value;
         }
         return null;
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
         _loc1_.open(Stash.click("skin_level_up",_popup.stashParams));
      }
   }
}
