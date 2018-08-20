package game.view.gui.debug
{
   import feathers.controls.IScrollBar;
   import feathers.controls.Label;
   import feathers.controls.List;
   import feathers.controls.ScrollContainer;
   import feathers.controls.SimpleScrollBar;
   import feathers.controls.TextInput;
   import feathers.controls.text.StageTextTextEditor;
   import feathers.data.ListCollection;
   import feathers.display.Scale9Image;
   import feathers.layout.VerticalLayout;
   import game.model.GameModel;
   import game.util.ConsoleCommands;
   import game.util.ConsoleCommandsProvider;
   import game.util.logging.Log;
   import game.util.logging.LogAggregator;
   import game.util.logging.LogGroup;
   import game.util.logging.LogRecord;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.events.KeyboardEvent;
   
   public class LogView
   {
      
      public static const textPadding:int = 4;
      
      public static const inputHeight:int = 18;
      
      protected static const LOG_NAMES_WIDTH:Number = 230;
       
      
      protected var logGroups:Vector.<LogGroupView>;
      
      protected var records:Vector.<LogRecord>;
      
      protected var commandsProvider:ConsoleCommandsProvider;
      
      protected var hidden:Boolean;
      
      var scrollContainer:ScrollContainer;
      
      protected var input:TextInput;
      
      protected var bg:Scale9Image;
      
      protected var text:List;
      
      protected var container:DisplayObjectContainer;
      
      protected var _previousMaxScrollPosition:int;
      
      protected var width:int;
      
      protected var height:int;
      
      protected var inited:Boolean = false;
      
      private var savedText:String = null;
      
      private var savedSelectionIndex:int = 0;
      
      private var savedSelectionBeginIndex:int;
      
      private var savedSelectionEndIndex:int;
      
      public function LogView()
      {
         super();
         hidden = true;
         Starling.current.stage.addEventListener("keyDown",onKeyDown);
         GameModel.instance.player.signal_update.initSignal.add(function():*
         {
            var _loc1_:* = null;
         });
      }
      
      public function get graphics() : DisplayObject
      {
         return container;
      }
      
      protected function init() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function setConsoleText(param1:String) : void
      {
         text.dataProvider = new ListCollection(param1.split("\n"));
         text.verticalScrollPosition = text.maxVerticalScrollPosition;
      }
      
      protected function setInputText(param1:String) : void
      {
         input.text = param1;
         input.selectRange(param1.length,param1.length);
      }
      
      protected function updateLogText(param1:LogGroupView) : void
      {
         graphics.parent.setChildIndex(graphics,graphics.parent.numChildren);
         takeLog();
         text.dataProvider = new ListCollection(records);
         text.verticalScrollPosition = text.maxVerticalScrollPosition;
      }
      
      protected function takeLog() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private final function toggleVisibility() : void
      {
         if(hidden)
         {
            show();
         }
         else
         {
            hide();
         }
      }
      
      private function hide() : void
      {
         savedSelectionBeginIndex = input.selectionBeginIndex;
         savedSelectionEndIndex = input.selectionEndIndex;
         input.clearFocus();
         hidden = true;
         container.removeFromParent();
      }
      
      private function show() : void
      {
         if(!inited)
         {
            init();
         }
         Starling.current.stage.addChild(container);
         hidden = false;
         input.setFocus();
         fixSavedSelectionIndicesByRealTextLength();
         input.selectRange(savedSelectionBeginIndex,savedSelectionEndIndex);
      }
      
      private function consoleScrollBarFactory() : IScrollBar
      {
         var _loc1_:SimpleScrollBar = new SimpleScrollBar();
         _loc1_.clampToRange = false;
         _loc1_.thumbProperties.minHeight = 40;
         _loc1_.thumbProperties.defaultSkin = new Image(LogStyleFactory.instance.thumbTexture);
         return _loc1_;
      }
      
      private function fixSavedSelectionIndicesByRealTextLength() : void
      {
         if(savedSelectionBeginIndex > input.text.length)
         {
            savedSelectionBeginIndex = input.text.length;
         }
         if(savedSelectionEndIndex > input.text.length)
         {
            savedSelectionEndIndex = input.text.length;
         }
      }
      
      protected function onLogGroupAdded(param1:LogGroup) : void
      {
         var _loc2_:LogGroupView = new LogGroupView(this,param1);
         logGroups.push(_loc2_);
         _loc2_.onSelectionChanged.add(updateLogText);
         _loc2_.onRecordAdded.add(onLogRecordAdded);
      }
      
      protected function onLogRecordAdded(param1:LogRecord) : void
      {
         if(text.dataProvider == null)
         {
            return;
         }
         text.dataProvider.addItem(param1);
         if(text.verticalScrollPosition >= _previousMaxScrollPosition)
         {
            text.invalidate("size");
            text.validate();
            var _loc2_:* = text.maxVerticalScrollPosition;
            text.verticalScrollPosition = _loc2_;
            _previousMaxScrollPosition = _loc2_;
         }
      }
      
      protected function onKeyDown(param1:KeyboardEvent) : void
      {
         savedText = null;
         if(param1.keyCode == 192)
         {
            if(inited)
            {
               savedText = input.text;
            }
            toggleVisibility();
            param1.stopImmediatePropagation();
            param1.preventDefault();
         }
         else if(!hidden)
         {
            processCommandKeys(param1.keyCode);
         }
      }
      
      protected function processCommandKeys(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1 == 13)
         {
            _loc2_ = String(commandsProvider.execute(input.text));
            input.text = "";
            if(_loc2_.length > 0)
            {
               setConsoleText(_loc2_);
            }
            else
            {
               hide();
            }
         }
         else if(param1 == 38)
         {
            _loc3_ = commandsProvider.askPreviousCommand();
            if(_loc3_)
            {
               setInputText(_loc3_);
            }
         }
         else if(param1 == 40)
         {
            _loc3_ = commandsProvider.askNextCommand();
            if(_loc3_)
            {
               setInputText(_loc3_);
            }
         }
         else if(param1 == 9)
         {
            _loc3_ = commandsProvider.askSimilarCommand(input.text);
            if(_loc3_)
            {
               setInputText(_loc3_);
            }
         }
      }
      
      protected function onInputChanged(param1:Event) : void
      {
         var _loc2_:* = null;
         if(savedText != null)
         {
            _loc2_ = savedText;
            savedText = null;
            input.text = _loc2_;
         }
      }
   }
}
