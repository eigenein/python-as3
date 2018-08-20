package game.view.popup.birthday
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.merge.MergeInfoBonusRendererClip;
   
   public class BirthDayPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_title:ClipLabel;
      
      public var tf_bonus:ClipLabel;
      
      public var tf_cooldown:SpecialClipLabel;
      
      public var bonus_renderer_1:MergeInfoBonusRendererClip;
      
      public var bonus_renderer_2:MergeInfoBonusRendererClip;
      
      public var bonus_renderer_3:MergeInfoBonusRendererClip;
      
      public var bonus_renderer_4:MergeInfoBonusRendererClip;
      
      public var bonus_renderer_5:MergeInfoBonusRendererClip;
      
      public var bonus_renderer_6:MergeInfoBonusRendererClip;
      
      public var action_btn:ClipButtonLabeled;
      
      public var rays_inst1:GuiAnimation;
      
      public function BirthDayPopUpClip()
      {
         tf_header = new ClipLabel();
         tf_title = new ClipLabel();
         tf_bonus = new ClipLabel();
         tf_cooldown = new SpecialClipLabel();
         bonus_renderer_1 = new MergeInfoBonusRendererClip();
         bonus_renderer_2 = new MergeInfoBonusRendererClip();
         bonus_renderer_3 = new MergeInfoBonusRendererClip();
         bonus_renderer_4 = new MergeInfoBonusRendererClip();
         bonus_renderer_5 = new MergeInfoBonusRendererClip();
         bonus_renderer_6 = new MergeInfoBonusRendererClip();
         action_btn = new ClipButtonLabeled();
         rays_inst1 = new GuiAnimation();
         super();
      }
   }
}
