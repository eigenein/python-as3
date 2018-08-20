package game.view.popup.test.grade
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   
   public class BattleTestGradeClip extends GuiClipNestedContainer
   {
       
      
      public var button_level:ClipButtonLabeled;
      
      public var button_color:ClipButtonLabeled;
      
      public var button_color_plus:ClipButtonLabeled;
      
      public var button_stars:ClipButtonLabeled;
      
      public var slider:Vector.<BattleGradeSlider>;
      
      public var slider_level:BattleGradeSlider;
      
      public var slider_color:BattleGradeSlider;
      
      public var slider_star:BattleGradeSlider;
      
      public var slider_skill:BattleGradeSlider;
      
      public var slider_skill_level:BattleGradeSlider;
      
      public var slider_rune:BattleGradeSlider;
      
      public var slider_skin1:BattleGradeSlider;
      
      public var slider_skin2:BattleGradeSlider;
      
      public var slider_skin3:BattleGradeSlider;
      
      public function BattleTestGradeClip()
      {
         super();
      }
   }
}
