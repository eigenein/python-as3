package game.view.popup.chestrewardheroeslist
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ChestRewardHeroesListRendererClip extends GuiClipNestedContainer
   {
       
      
      public var title_tf:ClipLabel;
      
      public var bg:ClipButton;
      
      public var hero_view:ChestRewardHeroesListRendererHeroView;
      
      public var bg_selected:GuiClipScale9Image;
      
      public var title_layout:ClipLayout;
      
      public function ChestRewardHeroesListRendererClip()
      {
         title_tf = new ClipLabel();
         bg = new ClipButton();
         hero_view = new ChestRewardHeroesListRendererHeroView();
         bg_selected = new GuiClipScale9Image(new Rectangle(23,23,2,2));
         title_layout = ClipLayout.verticalMiddleCenter(4,title_tf);
         super();
      }
   }
}
