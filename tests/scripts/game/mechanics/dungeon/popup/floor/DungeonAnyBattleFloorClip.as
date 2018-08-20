package game.mechanics.dungeon.popup.floor
{
   import engine.core.clipgui.GuiClipContainer;
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.mediator.DungeonFloorValueObject;
   import game.view.gui.components.ClipDataProvider;
   
   public class DungeonAnyBattleFloorClip extends DungeonBattleFloorClip
   {
       
      
      public var battle_display:DungeonBattleButtonDisplayBase;
      
      public var battle_display_container:GuiClipContainer;
      
      public var battle_display_hero:ClipDataProvider;
      
      public var battle_display_titan:ClipDataProvider;
      
      public function DungeonAnyBattleFloorClip()
      {
         battle_display_hero = new ClipDataProvider();
         battle_display_titan = new ClipDataProvider();
         super();
      }
      
      override public function createBattleButton(param1:DungeonFloorValueObject) : void
      {
         if(param1.desc.type.isTitanBattle)
         {
            battle_display = new DungeonTitanBattleFloorButtonDisplay();
            AssetStorage.rsx.popup_theme.factory.create(battle_display,battle_display_titan.clip);
         }
         else
         {
            battle_display = new DungeonHeroBattleFloorClipButtonDisplay();
            AssetStorage.rsx.popup_theme.factory.create(battle_display,battle_display_hero.clip);
         }
         battle_display_container.container.addChild(battle_display.graphics);
         battle_display.createBattleButton(param1);
      }
      
      override public function getBattleDisplayClip() : DungeonBattleButtonDisplayBase
      {
         return battle_display;
      }
   }
}
