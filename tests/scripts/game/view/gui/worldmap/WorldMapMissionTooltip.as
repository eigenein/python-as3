package game.view.gui.worldmap
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.worldmap.WorldMapViewMissionValueObject;
   import game.view.gui.components.GuiClipLayoutContainer;
   import starling.display.Image;
   
   public class WorldMapMissionTooltip extends GuiClipNestedContainer
   {
       
      
      private var bg:Image;
      
      private var image:Image;
      
      public var star_32x32_inst1:ClipSprite;
      
      public var star_32x32_inst2:ClipSprite;
      
      public var star_32x32_inst3:ClipSprite;
      
      public var starEmpty_32x32_inst1:ClipSprite;
      
      public var starEmpty_32x32_inst2:ClipSprite;
      
      public var starEmpty_32x32_inst3:ClipSprite;
      
      public var bubble_bg:ClipSprite;
      
      public var bubble_bg_elite:ClipSprite;
      
      public var heroBubbleFrame_inst0:ClipSprite;
      
      public var marker_container_hero_portrait_inst0:GuiClipLayoutContainer;
      
      public function WorldMapMissionTooltip()
      {
         super();
      }
      
      public function updateStarCount(param1:WorldMapViewMissionValueObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = 3;
            _loc3_ = 1;
            while(_loc3_ <= _loc2_)
            {
               (this["starEmpty_32x32_inst" + _loc3_] as ClipSprite).graphics.visible = param1.stars < _loc3_;
               (this["star_32x32_inst" + _loc3_] as ClipSprite).graphics.visible = param1.stars >= _loc3_;
               _loc3_++;
            }
         }
      }
      
      public function setData(param1:WorldMapViewMissionValueObject) : void
      {
         graphics.visible = param1;
         if(!param1)
         {
            return;
         }
         bubble_bg_elite.graphics.visible = param1.isMajor;
         bubble_bg.graphics.visible = !param1.isMajor;
         heroBubbleFrame_inst0.graphics.visible = param1.isMajor;
         marker_container_hero_portrait_inst0.graphics.visible = param1.isMajor;
         if(bg)
         {
            marker_container_hero_portrait_inst0.container.removeChild(bg);
            bg = null;
         }
         if(image)
         {
            marker_container_hero_portrait_inst0.container.removeChild(image);
            image = null;
         }
         if(param1.isMajor && param1.heroIcon)
         {
            bg = new Image(param1.heroIconBg);
            image = new Image(param1.heroIcon);
            var _loc2_:* = marker_container_hero_portrait_inst0.container.bounds.width;
            image.height = _loc2_;
            _loc2_ = _loc2_;
            image.width = _loc2_;
            _loc2_ = _loc2_;
            bg.height = _loc2_;
            bg.width = _loc2_;
            marker_container_hero_portrait_inst0.container.addChild(bg);
            marker_container_hero_portrait_inst0.container.addChild(image);
         }
         updateStarCount(param1);
      }
   }
}
