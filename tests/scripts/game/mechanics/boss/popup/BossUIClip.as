package game.mechanics.boss.popup
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class BossUIClip extends ClipAnimatedContainer
   {
       
      
      public var tf_level:ClipLabel;
      
      public var tf_avaliable:ClipLabel;
      
      public var btn_green:ClipButtonLabeled;
      
      public var btn_brown:ClipButtonLabeled;
      
      public var marker:ClipSprite;
      
      public var tf_raid_tomorrow:ClipLabel;
      
      public function BossUIClip()
      {
         tf_level = new ClipLabel();
         tf_avaliable = new ClipLabel();
         btn_green = new ClipButtonLabeled();
         btn_brown = new ClipButtonLabeled();
         marker = new ClipSprite();
         tf_raid_tomorrow = new ClipLabel();
         super();
      }
   }
}
