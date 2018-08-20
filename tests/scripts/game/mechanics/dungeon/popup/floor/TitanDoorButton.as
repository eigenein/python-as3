package game.mechanics.dungeon.popup.floor
{
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.model.state.DungeonFloorElementalGroup;
   
   public class TitanDoorButton extends DungeonDoorButtonBase
   {
       
      
      private var up_1:GuiAnimation;
      
      private var up_2:GuiAnimation;
      
      private var over_1:GuiAnimation;
      
      private var over_2:GuiAnimation;
      
      public var door:DungeonFloorTitanDoorClip;
      
      public function TitanDoorButton()
      {
         door = new DungeonFloorTitanDoorClip();
         super();
      }
      
      override public function set hoverAnimationIntensity(param1:int) : void
      {
         .super.hoverAnimationIntensity = param1;
         if(door)
         {
            adjustIntensity(up_1,100 - param1);
            adjustIntensity(up_2,100 - param1);
            adjustIntensity(over_1,param1);
            adjustIntensity(over_2,param1);
         }
      }
      
      public function setElements(param1:DungeonFloorElementalGroup) : void
      {
         door.element_1.container.addChild(createDoorPart("emblem_" + param1.element1.ident).graphics);
         var _loc2_:* = param1.differentElements;
         door.element_2.graphics.visible = _loc2_;
         _loc2_ = _loc2_;
         door.element_2_up.graphics.visible = _loc2_;
         door.element_2_over.graphics.visible = _loc2_;
         if(door.element_2.graphics.visible)
         {
            door.element_2.container.addChild(createDoorPart("emblem_" + param1.element2.ident).graphics);
            up_2 = createDoorPart("emblem_" + param1.element2.ident + "_up");
            door.element_2_up.container.addChild(up_2.graphics);
            over_2 = createDoorPart("emblem_" + param1.element2.ident + "_over");
            door.element_2_over.container.addChild(over_2.graphics);
         }
         up_1 = createDoorPart("emblem_" + param1.element1.ident + "_up");
         door.element_1_up.container.addChild(up_1.graphics);
         over_1 = createDoorPart("emblem_" + param1.element1.ident + "_over");
         door.element_1_over.container.addChild(over_1.graphics);
         hoverAnimationIntensity = 0;
      }
      
      protected function createDoorPart(param1:String) : GuiAnimation
      {
         var _loc2_:GuiAnimation = AssetStorage.rsx.dungeon_floors.create(GuiAnimation,param1);
         return _loc2_;
      }
   }
}
