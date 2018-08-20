package game.view.popup.dailybonus
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class DailyBonusPopupVipNeededClip extends GuiClipNestedContainer
   {
       
      
      public var button_bank:ClipButtonLabeled;
      
      public var button_cancel:ClipButtonLabeled;
      
      public var tf_caption:ClipLabel;
      
      public var tf_question:ClipLabel;
      
      public function DailyBonusPopupVipNeededClip()
      {
         button_bank = new ClipButtonLabeled();
         button_cancel = new ClipButtonLabeled();
         tf_caption = new ClipLabel();
         tf_question = new ClipLabel();
         super();
      }
   }
}
