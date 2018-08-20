package game.mechanics.dungeon.popup.floor
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import starling.core.Starling;
   import starling.display.Sprite;
   
   public class DungeonBattleFloorWithStairsClip extends DungeonAnyBattleFloorClip
   {
       
      
      public var stairs_glow_back:GuiAnimation;
      
      public var stairs_glow_front:GuiAnimation;
      
      public var stairs_front:Vector.<ClipSprite>;
      
      public var frontContainer:Sprite;
      
      public function DungeonBattleFloorWithStairsClip()
      {
         stairs_glow_back = new GuiAnimation();
         stairs_glow_front = new GuiAnimation();
         stairs_front = new Vector.<ClipSprite>();
         frontContainer = new Sprite();
         super();
         frontContainer.touchable = false;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(stairs_glow_front.isCreated)
         {
            frontContainer.addChild(stairs_glow_front.graphics);
         }
         var _loc4_:int = 0;
         var _loc3_:* = stairs_front;
         for each(var _loc2_ in stairs_front)
         {
            if(_loc2_ != null)
            {
               frontContainer.addChild(_loc2_.graphics);
            }
         }
         frontContainer.addChild(frame.graphics);
      }
      
      public function tweenStairsGlowOn(param1:Number) : void
      {
         if(stairs_glow_back.isCreated)
         {
            stairs_glow_back.graphics.visible = true;
            stairs_glow_back.graphics.alpha = 0;
            Starling.juggler.tween(stairs_glow_back.graphics,param1,{"alpha":1});
         }
         if(stairs_glow_front.isCreated)
         {
            stairs_glow_front.graphics.visible = true;
            stairs_glow_front.graphics.alpha = 0;
            Starling.juggler.tween(stairs_glow_front.graphics,param1,{"alpha":1});
         }
      }
      
      public function tweenStairsGlowOff(param1:Number) : void
      {
         if(stairs_glow_back.isCreated)
         {
            stairs_glow_back.graphics.visible = true;
            stairs_glow_back.graphics.alpha = 1;
            Starling.juggler.tween(stairs_glow_back.graphics,param1,{
               "alpha":0,
               "onComplete":turnStairsGlowOff
            });
         }
         if(stairs_glow_front.isCreated)
         {
            stairs_glow_front.graphics.visible = true;
            stairs_glow_front.graphics.alpha = 1;
            Starling.juggler.tween(stairs_glow_front.graphics,param1,{
               "alpha":0,
               "onComplete":turnStairsGlowOff
            });
         }
      }
      
      public function turnStairsGlowOff() : void
      {
         if(stairs_glow_back.isCreated)
         {
            stairs_glow_back.graphics.visible = false;
         }
         if(stairs_glow_front.isCreated)
         {
            stairs_glow_front.graphics.visible = false;
         }
      }
   }
}
