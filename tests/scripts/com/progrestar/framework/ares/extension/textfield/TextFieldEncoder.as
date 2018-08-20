package com.progrestar.framework.ares.extension.textfield
{
   import com.progrestar.framework.ares.io.IByteArrayReadOnly;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class TextFieldEncoder
   {
       
      
      public function TextFieldEncoder()
      {
         super();
      }
      
      public static function write(param1:ClipTextField, param2:ByteArray) : void
      {
         param2.writeShort(param1.clipId);
         param2.writeUTF(param1.name);
         param2.writeUTF(param1.fontClass);
         param2.writeShort(int(param1.fontHeight * 100));
         param2.writeInt(param1.textColor);
         param2.writeByte(param1.align);
         param2.writeBoolean(param1.multiline);
      }
      
      public static function read(param1:IByteArrayReadOnly) : ClipTextField
      {
         var _loc2_:ClipTextField = new ClipTextField();
         _loc2_.clipId = param1.readUnsignedShort();
         _loc2_.name = param1.readUTF();
         _loc2_.fontClass = param1.readUTF();
         _loc2_.fontHeight = param1.readUnsignedShort() / 100;
         _loc2_.textColor = param1.readUnsignedInt();
         _loc2_.align = param1.readByte();
         _loc2_.multiline = param1.readBoolean();
         return _loc2_;
      }
      
      public static function createClipTextField(param1:TextField) : ClipTextField
      {
         var _loc2_:ClipTextField = new ClipTextField();
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc2_.name = param1.name;
         _loc2_.fontClass = _loc3_.font;
         _loc2_.fontHeight = Number(_loc3_.size);
         _loc2_.align = tfAlignToAlignCode(_loc3_.align);
         _loc2_.textColor = uint(_loc3_.color);
         _loc2_.multiline = param1.multiline;
         return _loc2_;
      }
      
      public static function tfAlignToAlignCode(param1:String) : uint
      {
         var _loc2_:* = param1;
         if("left" !== _loc2_)
         {
            if("right" !== _loc2_)
            {
               if("center" !== _loc2_)
               {
                  if("justify" !== _loc2_)
                  {
                     if("start" !== _loc2_)
                     {
                        if("end" !== _loc2_)
                        {
                           return 0;
                        }
                        return 5;
                     }
                     return 4;
                  }
                  return 3;
               }
               return 2;
            }
            return 1;
         }
         return 0;
      }
      
      public static function tfAlignCodeToAlign(param1:int) : String
      {
         switch(int(param1))
         {
            case 0:
               return "left";
            case 1:
               return "right";
            case 2:
               return "center";
            case 3:
               return "justify";
            case 4:
               return "start";
            case 5:
               return "end";
         }
      }
   }
}
