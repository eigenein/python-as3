package game.view.gui.components.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   
   public class MiniHeroPortraitClipWithLevelAndHP extends MiniHeroPortraitClipWithLevel
   {
       
      
      private const minWidth:int = 7;
      
      private var healthMaxWidth:int;
      
      private var healthDefaultY:int;
      
      private var healthDefaultBGY:int;
      
      public var progress_bar_health:GuiClipScale3Image;
      
      public var progress_bar_health_bg:ClipSprite;
      
      public function MiniHeroPortraitClipWithLevelAndHP()
      {
         progress_bar_health = new GuiClipScale3Image();
         progress_bar_health_bg = new ClipSprite();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         healthMaxWidth = int(progress_bar_health.graphics.width);
         healthDefaultY = int(progress_bar_health.graphics.y);
         healthDefaultBGY = int(progress_bar_health_bg.graphics.y);
      }
      
      override public function set data(param1:UnitEntryValueObject) : void
      {
         .super.data = param1;
         if(param1 is TitanEntryValueObject)
         {
            progress_bar_health.graphics.y = healthDefaultY - 4;
            progress_bar_health_bg.graphics.y = healthDefaultBGY - 4;
         }
         else
         {
            progress_bar_health.graphics.y = healthDefaultY;
            progress_bar_health_bg.graphics.y = healthDefaultBGY;
         }
      }
      
      public function setHPPercent(param1:Number) : void
      {
         if(!isNaN(param1) && param1 > 0)
         {
            progress_bar_health.graphics.visible = true;
            progress_bar_health.graphics.width = Math.max(7,int(healthMaxWidth * param1));
         }
         else
         {
            progress_bar_health.graphics.visible = false;
         }
      }
   }
}
