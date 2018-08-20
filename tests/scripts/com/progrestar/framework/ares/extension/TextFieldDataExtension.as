package com.progrestar.framework.ares.extension
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.extension.textfield.ClipTextField;
   import com.progrestar.framework.ares.extension.textfield.TextFieldEncoder;
   import com.progrestar.framework.ares.io.IByteArrayReadOnly;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TextFieldDataExtension extends DataExtensionBase
   {
      
      public static const TYPE:DataExtensionType = new DataExtensionType(TextFieldDataExtension,"textfield");
       
      
      public var textFields:Vector.<ClipTextField>;
      
      public function TextFieldDataExtension(param1:ClipAsset)
      {
         textFields = new Vector.<ClipTextField>();
         super(param1);
      }
      
      public static function fromAsset(param1:ClipAsset) : TextFieldDataExtension
      {
         return param1.getData(TYPE) as TextFieldDataExtension;
      }
      
      override public function get type() : DataExtensionType
      {
         return TYPE;
      }
      
      override public function get isEmpty() : Boolean
      {
         return textFields.length == 0;
      }
      
      public function addTextField(param1:TextField, param2:Clip) : void
      {
         var _loc3_:ClipTextField = TextFieldEncoder.createClipTextField(param1);
         _loc3_.clipId = param2.id;
         textFields.push(_loc3_);
      }
      
      public function getClipTextField(param1:Clip) : ClipTextField
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function write(param1:ByteArray) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = textFields.length;
         param1.writeShort(_loc2_);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            TextFieldEncoder.write(textFields[_loc3_],param1);
            _loc3_++;
         }
      }
      
      override public function readChunk(param1:IByteArrayReadOnly) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readUnsignedShort();
         textFields.length = _loc2_;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            textFields[_loc3_] = TextFieldEncoder.read(param1);
            _loc3_++;
         }
      }
   }
}
