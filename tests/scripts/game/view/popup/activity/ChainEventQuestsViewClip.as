package game.view.popup.activity
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledAlphaGradientList;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ChainEventQuestsViewClip extends ClipAnimatedContainer
   {
       
      
      public var tf_caption:ClipLabel;
      
      public var chain_list_container:GuiClipLayoutContainer;
      
      public var tf_empty:ClipLabel;
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var tf_quest_caption:ClipLabel;
      
      public var scroll_bar:GameScrollBar;
      
      public var quest_list:GameScrolledAlphaGradientList;
      
      public const custom_content:GuiClipLayoutContainer = new GuiClipLayoutContainer();
      
      private var _twoRowsOfTabs:Boolean;
      
      private var _tallContent:Boolean;
      
      private var _showQuestList:Boolean;
      
      public function ChainEventQuestsViewClip()
      {
         tf_caption = new ClipLabel();
         chain_list_container = new GuiClipLayoutContainer();
         tf_empty = new ClipLabel();
         dialog_frame = new GuiClipScale9Image();
         tf_quest_caption = new ClipLabel();
         scroll_bar = new GameScrollBar();
         quest_list = new GameScrolledAlphaGradientList(scroll_bar,20);
         super(true);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         playback.gotoAndStop(0);
      }
      
      public function set twoRowsOfTabs(param1:Boolean) : void
      {
         _twoRowsOfTabs = param1;
         updateFrame();
      }
      
      public function set tallContent(param1:Boolean) : void
      {
         _tallContent = param1;
         updateFrame();
      }
      
      public function set showQuestList(param1:Boolean) : void
      {
         _showQuestList = param1;
         updateFrame();
      }
      
      protected function updateFrame() : void
      {
         var _loc1_:int = 0;
         if(_showQuestList)
         {
            if(_tallContent)
            {
               _loc1_ = 2;
            }
            else
            {
               _loc1_ = 0;
            }
         }
         else
         {
            _loc1_ = 4;
         }
         if(!_twoRowsOfTabs)
         {
            _loc1_++;
         }
         playback.gotoAndStop(_loc1_);
      }
   }
}
