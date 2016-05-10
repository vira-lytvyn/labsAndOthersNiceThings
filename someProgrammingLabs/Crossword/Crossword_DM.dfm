object DM: TDM
  OldCreateOrder = False
  Height = 342
  Width = 299
  object sqlcDict: TSQLConnection
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxint30.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=database.gdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    Left = 56
    Top = 24
  end
  object dlgOpen: TOpenDialog
    Left = 112
    Top = 24
  end
  object sidsTopics: TSimpleDataSet
    Aggregates = <>
    Connection = sqlcDict
    DataSet.CommandText = 'SELECT * FROM TOPICS'#13#10'ORDER BY TOPIC_NAME'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 168
    Top = 24
  end
  object sspDelTopic: TSQLStoredProc
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'pTopicID'
        ParamType = ptInput
      end>
    SQLConnection = sqlcDict
    StoredProcName = 'DELETE_FROM_TOPICS'
    Left = 56
    Top = 152
  end
  object sspFindTopic: TSQLStoredProc
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'pTopicName'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'rTopicID'
        ParamType = ptResult
      end>
    SQLConnection = sqlcDict
    StoredProcName = 'FIND_TOPIC_ID'
    Left = 56
    Top = 88
  end
  object sspAddTopic: TSQLStoredProc
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'pTopicName'
        ParamType = ptInput
      end>
    SQLConnection = sqlcDict
    StoredProcName = 'INSERT_INTO_TOPICS'
    Left = 56
    Top = 200
  end
  object sspEditTopic: TSQLStoredProc
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'pTopicID'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pTopicName'
        ParamType = ptInput
      end>
    SQLConnection = sqlcDict
    StoredProcName = 'UPDATE_TOPICS'
    Left = 56
    Top = 256
  end
  object sidsWords: TSimpleDataSet
    Aggregates = <>
    Connection = sqlcDict
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 240
    Top = 24
  end
  object sspDelWord: TSQLStoredProc
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'pWordID'
        ParamType = ptInput
      end>
    SQLConnection = sqlcDict
    StoredProcName = 'DELETE_FROM_WORDS'
    Left = 136
    Top = 152
  end
  object sspAddWord: TSQLStoredProc
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'pWordTopic'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC01'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC02'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC03'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC04'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC05'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC06'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC07'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC08'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC09'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC10'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC11'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC12'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC13'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC14'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC15'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordDescr'
        ParamType = ptInput
      end>
    SQLConnection = sqlcDict
    StoredProcName = 'INSERT_INTO_WORDS'
    Left = 136
    Top = 200
  end
  object sspEditWord: TSQLStoredProc
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'pWordID'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordTopic'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC01'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC02'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC03'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC04'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC05'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC06'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC07'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC08'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC09'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC10'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC11'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC12'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC13'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC14'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordC15'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'pWordDescr'
        ParamType = ptInput
      end>
    SQLConnection = sqlcDict
    StoredProcName = 'UPDATE_WORDS'
    Left = 136
    Top = 256
  end
  object sqlqTopics: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select topic_name from topics'
      'order by topic_name')
    SQLConnection = sqlcDict
    Left = 136
    Top = 88
  end
  object sidsFindWord: TSimpleDataSet
    Aggregates = <>
    Connection = sqlcDict
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 224
    Top = 88
  end
end
