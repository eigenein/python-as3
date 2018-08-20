package game.mechanics.quiz.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.quiz.model.QuizQuestionValueObject;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.SpecialClipLabel;
   
   public class QuizQuestionTextRenderer extends GuiClipNestedContainer
   {
       
      
      public var tf_text:SpecialClipLabel;
      
      public var icon:QuizIconRenderer;
      
      public var layout_question:ClipLayout;
      
      public var icon_container:ClipLayout;
      
      private var characterSprite:ClipSprite;
      
      public function QuizQuestionTextRenderer()
      {
         tf_text = new SpecialClipLabel(false,false,true);
         icon = new QuizIconRenderer();
         layout_question = ClipLayout.verticalMiddleCenter(4,tf_text,icon);
         icon_container = new ClipLayoutNone();
         super();
      }
      
      public function setData(param1:QuizQuestionValueObject) : void
      {
         tf_text.text = param1.text;
         icon.graphics.visible = param1.questionIcon;
         if(param1.questionIcon)
         {
            icon.setData(param1.questionIcon);
         }
         if(characterSprite)
         {
            container.removeChild(characterSprite.graphics);
         }
         var _loc2_:RsxGuiAsset = AssetStorage.rsx.getByName("quiz_popup") as RsxGuiAsset;
         switch(int(param1.difficulty) - 1)
         {
            case 0:
               characterSprite = _loc2_.create(ClipSprite,"icon_hero1");
               break;
            case 1:
               characterSprite = _loc2_.create(ClipSprite,"icon_hero2");
               break;
            case 2:
               characterSprite = _loc2_.create(ClipSprite,"icon_hero3");
         }
         characterSprite.graphics.x = icon_container.x;
         characterSprite.graphics.y = icon_container.y;
         container.addChild(characterSprite.graphics);
      }
   }
}
